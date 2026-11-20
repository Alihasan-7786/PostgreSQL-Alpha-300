-- Creating a table to store city details
CREATE TABLE cities (
    name VARCHAR(50),
    country VARCHAR(50),
    population INTEGER,
    area INTEGER
);

-- Adding details of different cities into the table
INSERT INTO cities (name, country, population, area)
VALUES
    ('Tokyo', 'Japan', 38505000, 8223),
    ('Delhi', 'India', 28125000, 2240),
    ('Shanghai', 'China', 22125000, 4015),
    ('Sao Paulo', 'Brazil', 20935000, 3043);

-- Displaying the city names and calculating population density and we can use different mathamatical symbols as *,/,+...
SELECT name, population / area AS population_density
FROM cities;

-- Combining city and country names and displaying city names in uppercase
SELECT name || ', ' || country AS location,
UPPER(name) AS upper_name
FROM cities;

-- Finding cities with area greater than 4000 and using another AND function to find the area greater then 4000 in Japan or China
SELECT name, area
FROM cities
WHERE area > 4000
  AND country IN ('Japan', 'China');

-- Changing the population of Tokyo using UPDATE 
UPDATE cities
SET population = 39000000
WHERE name = 'Tokyo';

-- Removing Sao Paulo from the table using DELETE 
DELETE FROM cities
WHERE name = 'Sao Paulo';