USE lab7;

DROP PROCEDURE IF EXISTS insert_into_password;
DROP PROCEDURE IF EXISTS insert_into_book_10;
DROP PROCEDURE IF EXISTS create_new_db_of_books;

DELIMITER //
CREATE PROCEDURE insert_into_password(password VARCHAR(45))
BEGIN
INSERT INTO password (password ) VALUES (password);
END // 


CREATE PROCEDURE insert_into_book_10()
BEGIN
	DECLARE i INT;
    DECLARE str VARCHAR(45);
    SET i = 0,str = 'NoName';
    
    WHILE i < 10 DO
		SET i = i+1;
		INSERT INTO book (name,author,UDC,rating,catalog_tree_id ) VALUES (CONCAT(str,i),'name','aaaaaaa222',5,1);
	END WHILE;

END//

CREATE PROCEDURE create_new_db_of_books()
BEGIN
	DECLARE nameT, authorT VARCHAR(45);
	DECLARE done int DEFAULT false;
    
	DECLARE cursor1 CURSOR FOR SELECT name FROM book;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = true;
    
	OPEN cursor1;
    loop1: LOOP 
		FETCH cursor1 INTO nameT;
        IF done=true THEN LEAVE loop1;
        END IF;
        
        SET @tmp_query = CONCAT('CREATE DATABASE IF NOT EXISTS ',nameT);
        PREPARE myquery FROM @tmp_query;
        EXECUTE myquery;
        DEALLOCATE PREPARE myquery;
        
        
		SET @tmp_query3 = CONCAT(
        'CREATE TABLE IF NOT EXISTS `',CONCAT(nameT,1), '` 
        (
        `id` INT,
        `name` VARCHAR(45), 
        PRIMARY KEY (`id`)
        );'
        );
		PREPARE statement FROM @tmp_query3;
		EXECUTE statement;
		DEALLOCATE PREPARE statement ;
        
        
    END LOOP;
    CLOSE cursor1;

END //

DELIMITER ;

call create_new_db_of_books();

-- call insert_into_book_10();