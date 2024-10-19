-- Create a trigger to reset the valid_email
-- attribute when the email has been changed

DELIMITER $$

CREATE TRIGGER reset_valid_email
BEFORE UPDATE ON users
FOR EACH ROW
BEGIN
    -- Check if the email has been changed
    IF NEW.email <> OLD.email THEN
        SET NEW.valid_email = 0;
    END IF;
END$$

DELIMITER ;
