-- This Script selects band names and
-- compute lifespan using 2022 as the reference year


SELECT band_name, 
       (IFNULL(split, 2022) - formed) AS lifespan 
FROM metal_bands;
