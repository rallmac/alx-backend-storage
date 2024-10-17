-- This script lists all bands with Glam rock as their main style
-- ranked by their longevity, calculated as lifespan in
-- years (up to 2022)

-- Assuming metal_bands table is already imported
-- from metal_bands.sql
SELECT 
    band_name, 
    CASE 
        WHEN split IS NULL THEN (2022 - formed)
        ELSE (split - formed)
    END AS lifespan
FROM 
    metal_bands
WHERE 
    main_style = 'Glam rock'
ORDER BY 
    lifespan DESC;

