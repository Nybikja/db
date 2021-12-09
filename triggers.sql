USE lab7;
DROP TRIGGER IF EXISTS book_insert;
DROP TRIGGER IF EXISTS book_update;
DROP TRIGGER IF EXISTS book_delete;

DROP TRIGGER IF EXISTS catalog_tree_insert;
DROP TRIGGER IF EXISTS catalog_tree_update;
DROP TRIGGER IF EXISTS catalog_tree_delete;

DROP TRIGGER IF EXISTS link_insert;
DROP TRIGGER IF EXISTS link_update;

DROP TRIGGER IF EXISTS marker_insert;
DROP TRIGGER IF EXISTS marker_update;

DROP TRIGGER IF EXISTS password_insert;
DROP TRIGGER IF EXISTS password_update;

DROP TRIGGER IF EXISTS user_delete;

DELIMITER //

CREATE TRIGGER book_insert BEFORE INSERT ON book FOR EACH ROW 
BEGIN
   IF NOT new.catalog_tree_id in (SELECT id FROM catalog_tree)
THEN
   SIGNAL SQLSTATE '45000' 
   SET MESSAGE_TEXT = 'Catalog tree id not found';
END IF;
END // 


CREATE TRIGGER book_update BEFORE UPDATE ON book FOR EACH ROW 
   BEGIN
      IF NOT new.catalog_tree_id IN (SELECT id FROM catalog_tree)
   THEN
		SIGNAL SQLSTATE '45000' 
		SET MESSAGE_TEXT = "Ctalog tree id not found";
   END IF;
END //

CREATE TRIGGER book_delete BEFORE delete ON book FOR EACH ROW 
begin
	IF (old.id IN (SELECT book_id FROM link) OR 
		old.id IN (SELECT book_id FROM marker)) THEN
        SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = "Book can`t be delete. Book uses in other table";
    END IF; 
end //

CREATE TRIGGER catalog_tree_insert BEFORE insert ON catalog_tree FOR EACH ROW 
begin
	IF NOT new.parent_catalog_id IN (
		SELECT id FROM catalog_tree) THEN
			IF NOT new.parent_catalog_id IS NULL THEN
				SIGNAL SQLSTATE '45000'
				SET MESSAGE_TEXT = "Parent catalog NOT FOUND";
			END IF;
    END IF; 
end //



CREATE TRIGGER catalog_tree_update BEFORE update ON catalog_tree FOR EACH ROW 
begin
	IF NOT new.parent_catalog_id IN (
		SELECT id FROM catalog_tree) THEN
			IF NOT new.parent_catalog_id IS NULL THEN
				SIGNAL SQLSTATE '45000'
				SET MESSAGE_TEXT = "Parent catalog NOT FOUND";
			END IF;
    END IF; 
end //


CREATE TRIGGER catalog_tree_delete BEFORE delete ON catalog_tree FOR EACH ROW 
begin
IF (old.id IN (SELECT parent_catalog_id FROM catalog_tree)
		OR old.id IN (SELECT catalog_tree_id FROM book)) THEN
        SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = "catalog_tree id is in use.";
    END IF;
end //

CREATE TRIGGER link_insert BEFORE insert ON link FOR EACH ROW 
begin
	IF NOT new.book_id IN (
		SELECT id FROM book) THEN
        SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = "book NOT FOUND.";
	END IF;
end//

CREATE TRIGGER link_update BEFORE update ON link FOR EACH ROW 
begin
	IF NOT new.book_id IN (
		SELECT id FROM book) THEN
        SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = "book NOT FOUND.";
	END IF;
end//



CREATE TRIGGER marker_insert BEFORE insert ON marker FOR EACH ROW
begin
	IF NOT new.user_id IN (
		SELECT id FROM `user`) THEN
			SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = "user NOT FOUND.";
    END IF;
    IF NOT new.book_id IN (
		SELECT id FROM book) THEN
			SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = "book NOT FOUND.";
    END IF;
end//

CREATE TRIGGER marker_update BEFORE update ON marker FOR EACH ROW
begin
	IF NOT new.user_id IN (
		SELECT id FROM `user`) THEN
			SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = "user NOT FOUND.";
    END IF;
    IF NOT new.book_id IN (
		SELECT id FROM book) THEN
			SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = "book NOT FOUND.";
    END IF;
end//


CREATE TRIGGER password_insert BEFORE insert ON passwords FOR EACH ROW
begin
	IF NOT new.id IN (
		SELECT id FROM `user`) THEN
			SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = "user NOT FOUND.";
    END IF;
end//

CREATE TRIGGER password_update BEFORE update ON passwords FOR EACH ROW
begin
	IF NOT new.id IN (
		SELECT id FROM `user`) THEN
			SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = "user NOT FOUND.";
    END IF;
end//



CREATE TRIGGER user_delete BEFORE delete ON user FOR EACH ROW
begin
	IF old.id IN (SELECT user_id FROM marker) THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = "can't be delete. Remove from markers";
    END IF;
end//





DELIMITER ;