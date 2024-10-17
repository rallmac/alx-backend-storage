DELIMITER $$

CREATE PROCEDURE AddBonus(IN user_id INT, IN project_name VARCHAR(255), IN score INT)
BEGIN
    DECLARE project_id INT;

    -- Check if the project exists
    SELECT id INTO project_id
    FROM projects
    WHERE name = project_name
    LIMIT 1;

    -- If no project is found, insert the new project
    IF project_id IS NULL THEN
        INSERT INTO projects (name)
        VALUES (project_name);
        
        -- Get the project_id of the newly inserted project
        SET project_id = LAST_INSERT_ID();
    END IF;

    -- Insert the correction for the user
    INSERT INTO corrections (user_id, project_id, score)
    VALUES (user_id, project_id, score);
    
END$$

DELIMITER ;
