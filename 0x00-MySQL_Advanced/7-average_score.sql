-- This script creates a stored procedure which computes and
-- stores average score for students. Average score can be a decimal


DELIMITER $$

CREATE PROCEDURE ComputeAverageScoreForUser(IN user_id INT)
BEGIN
    DECLARE avg_score FLOAT;

    -- Compute the average score for the given user
    SELECT AVG(score) INTO avg_score
    FROM corrections
    WHERE user_id = user_id;

    -- Update the users table with the computed average score
    UPDATE users
    SET average_score = avg_score
    WHERE id = user_id;

END$$

DELIMITER ;
