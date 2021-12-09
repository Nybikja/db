USE lab7;
DROP FUNCTION IF EXISTS AVG_users_raiting;
DROP FUNCTION IF EXISTS get_password;

DELIMITER //
CREATE FUNCTION AVG_users_raiting()
	RETURNS INT
	DETERMINISTIC
BEGIN
	RETURN(SELECT avg(rating) FROM user);
END //

CREATE FUNCTION get_password(user_id INT)
	RETURNS VARCHAR(45)
	DETERMINISTIC
BEGIN
	RETURN(SELECT password FROM passwords WHERE id = user_id);
END //

DELIMITER ;

-- SELECT firstname, get_password(id) pass FROM user;

 SELECT * FROM user WHERE rating > AVG_users_raiting();