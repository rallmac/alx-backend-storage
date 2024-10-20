-- This creates a function SafeDiv divides and returns
-- Second number equals to zero

DELIMITER $$

CREATE FUNCTION SafeDiv(a INT, b INT)
RETURNS DECIMAL(10, 2)
DETERMINISTIC
BEGIN
    -- Return 0 if b is 0, otherwise return the result of a / b
    IF b = 0 THEN
        RETURN 0;
    ELSE
        RETURN a / b;
    END IF;
END$$

DELIMITER ;

