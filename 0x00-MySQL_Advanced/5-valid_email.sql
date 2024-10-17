-- Create a trigger to reset the valid_email
-- attribute when the email has been changed

DELIMITER $$

CREATE TRIGGER reset_valid_email
AFTER UPDATE ON users
FOR EACH ROW
BEGIN
    -- Check if the email has been changed
    IF NEW.email <> OLD.email THEN
        -- Reset the valid_email attribute
        UPDATE users
        SET valid_email = FALSE
        WHERE id = NEW.id;
    END IF;
END$$

DELIMITER ;
