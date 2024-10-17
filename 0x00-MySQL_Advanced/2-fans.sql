--This Script import a table
--Sorts content beased on unique fans
mysql -u username -p database_name < metal_bands.sql

SELECT origin, COUNT(DISTINCT nb_fans) as unique_fan_count
FROM fans
GROUP BY origin
ORDER BY unique_fan_count DESC;
