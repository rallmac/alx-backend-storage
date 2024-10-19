-- This script creates a stored proceedure
-- Computes and stores like the previous one

DELIMITER $$

CREATE PROCEDURE ComputeAverageWeightedScoreForUsers()
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE user_id INT;
    DECLARE avg_weighted_score DECIMAL(10,2);
    DECLARE cur CURSOR FOR 
        SELECT id FROM users;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    OPEN cur;

    read_loop: LOOP
        FETCH cur INTO user_id;  -- Fetch user ID into variable
        IF done THEN
            LEAVE read_loop;  -- Exit loop if no more users
        END IF;

        -- Calculate total weighted score and total weight for the current user
        SELECT 
            SUM(score * weight) INTO avg_weighted_score,
            SUM(weight) INTO total_weight
        FROM scores
        WHERE user_id = user_id;

        -- Compute the average weighted score if total weight > 0
        IF total_weight > 0 THEN
            SET avg_weighted_score = avg_weighted_score / total_weight;
        ELSE
            SET avg_weighted_score = 0; -- Avoid division by zero
        END IF;

        -- Update the users table with the computed average weighted score
        UPDATE users
        SET average_weighted_score = avg_weighted_score
        WHERE id = user_id;

    END LOOP;

    CLOSE cur;
END$$

DELIMITER ;
