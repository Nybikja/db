USE lab7;
DROP TRIGGER IF EXISTS user_filter_insert;
DROP TRIGGER IF EXISTS user_filter_update;
DROP TRIGGER IF EXISTS password_cardinality;


DELIMITER //

CREATE TRIGGER user_filter_insert BEFORE INSERT ON user FOR EACH ROW 
begin
	IF (new.surname rlike '^[ЮЯ]')
    THEN SIGNAL SQLSTATE "45000"
			SET MESSAGE_TEXT = "format invalid";
    END IF;
    IF (new.place_of_birth not rlike 'Харків|Вінниця|Дніпропетровськ|Ужгород')
    THEN SIGNAL SQLSTATE "45000"
			SET MESSAGE_TEXT = "place of birth invalid can be (Харків,Вінниця,Дніпропетровськ,Ужгород)";
    END IF;

end //

CREATE TRIGGER user_filter_update BEFORE UPDATE ON user FOR EACH ROW 
begin
	IF (new.surname rlike '^[ЮЯ]')
    THEN SIGNAL SQLSTATE "45000"
			SET MESSAGE_TEXT = "format invalid";
    END IF;
	 IF (new.place_of_birth not rlike 'Харків|Вінниця|Дніпропетровськ|Ужгород')
    THEN SIGNAL SQLSTATE "45000"
			SET MESSAGE_TEXT = "place of birth invalid can be (Харків,Вінниця,Дніпропетровськ,Ужгород)";
    END IF;
end //

CREATE TRIGGER password_cardinality after insert ON passwords FOR EACH ROW 
begin
	declare count1 int;
    set count1 = (SELECT COUNT(*) FROM passwords);
	IF (SELECT COUNT(*) FROM passwords) > 5 THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Cardinality constraint. Max 5 pass ';
    END IF;
end//

DELIMITER ;