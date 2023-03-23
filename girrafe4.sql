CREATE TABLE trigger_test (
	message VARCHAR(100)
);

DELIMITER $$
CREATE
	TRIGGER my_trigger BEFORE INSERT
    ON employee
    FOR EACH ROW BEGIN
		INSERT INTO trigger_test VALUES('');
	END$$
DELIMITER ;
INSERT INTO employee VALUES(110, 'Oscar', 'Martinez', '1968-02-19', 'M', 69000, 106, 3);
INSERT INTO employee VALUES(111, 'Kevin', 'Malone', '1978-02-19', 'M', 69000, 106, 3);
INSERT INTO employee VALUES(112, 'Pam', 'Beesly', '1988-02-19', 'F', 69000, 106, 3);
SELECT * FROM trigger_test;


CREATE
	TRIGGER my_trigger BEFORE INSERT
    ON employee
    FOR EACH ROW BEGIN
		INSERT INTO trigger_test VALUES(NEW.first_name);
	END$$

CREATE 
	TRIGGER my_trigger BEFORE INSERT
    ON employee
    FOR EACH ROW BEGIN
		IF NEW.sex = 'M' THEN
			INSERT INTO trigger_test VALUES('added male employee');
		ELSEIF NEW.sex = 'F' THEN
			INSERT INTO trigger_test VALUES('added female');
		ELSE 
			INSERT INTO trigger_test VALUES('added other employee');
		END IF;
	END$$;
    
    
    CREATE
	TRIGGER my_trigger AFTER DELETE
    ON employee
    FOR EACH ROW BEGIN
		INSERT INTO trigger_test VALUES('deleted');
	END$$

DROP TRIGGER my_trigger1;



