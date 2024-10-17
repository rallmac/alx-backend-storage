-- This script Creates a stored proceedure
-- Computes and stores average called average weighed score

DELIMITER $$

CREATE PROCEDURE ComputeAverageWeightedScoreForUser(IN user_id INT)
BEGIN
    DECLARE total_score DECIMAL(10,2);
    DECLARE total_weight DECIMAL(10,2);
    DECLARE avg_weighted_score DECIMAL(10,2);

    -- Initialize variables
    SET total_score = 0;
    SET total_weight = 0;

    -- Calculate the total score and total weight for the user
    SELECT SUM(score * weight) INTO total_score,
           SUM(weight) INTO total_weight
    FROM scores
    WHERE user_id = user_id;

    -- Compute the weighted average score
    IF total_weight > 0 THEN
        SET avg_weighted_score = total_score / total_weight;
    ELSE
        SET avg_weighted_score = 0; -- Avoid division by zero
    END IF;

    -- Update the users table with the computed average weighted score
    UPDATE users
    SET average_weighted_score = avg_weighted_score
    WHERE id = user_id;

END$$

DELIMITER ;

