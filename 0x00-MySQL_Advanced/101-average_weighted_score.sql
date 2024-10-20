-- This script creates a stored proceedure
-- Computes and stores like the previous one

DELIMITER $$

CREATE PROCEDURE ComputeAverageWeightedScoreForUsers()
BEGIN
    DECLARE done INT DEFAULT 0;
    DECLARE curr_user_id INT;

    -- Cursor to loop through all users
    DECLARE cur CURSOR FOR SELECT id FROM users;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    -- Start the cursor and loop through each user
    OPEN cur;
    
    read_loop: LOOP
        FETCH cur INTO curr_user_id;
        IF done THEN
            LEAVE read_loop;
        END IF;
        
        CALL ComputeAverageWeightedScoreForUser(curr_user_id);
    END LOOP;
    
    CLOSE cur;
END $$

DELIMITER ;
