-- This function finds data in database
-- using some criteria


SELECT 
    band_name, 
    IFNULL(split, 2022) - formed AS lifespan
FROM 
    metal_bands
WHERE 
    FIND_IN_SET('Glam rock', style) > 0
ORDER BY 
    lifespan DESC;
