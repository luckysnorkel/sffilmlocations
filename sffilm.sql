-- # of different filming locations
SELECT COUNT(DISTINCT Locations)
FROM film_locations_sf;

-- # of different films/shows
SELECT COUNT(DISTINCT Title)
FROM film_locations_sf;

-- Most popular film locations
SELECT Locations,
COUNT(DISTINCT Title) AS n_films
FROM film_locations_sf
GROUP BY Locations
ORDER BY n_films DESC;

-- Titles with the most filming locations
SELECT Title, 
COUNT(DISTINCT Locations) as n_locations
FROM film_locations_sf
GROUP BY Title
ORDER BY n_locations DESC;

-- Titles with the most diverse filming locations
SELECT Title,
COUNT(DISTINCT CurrentSupervisorDistricts) as n_districts,
COUNT(DISTINCT Locations) AS n_locations
FROM film_locations_sf
GROUP BY Title
HAVING COUNT(DISTINCT CurrentSupervisorDistricts) > 4
ORDER BY n_districts DESC, n_locations DESC;

-- Titles with the least diverse filming locations
SELECT Title,
COUNT(DISTINCT CurrentSupervisorDistricts) as n_districts,
COUNT(DISTINCT Locations) AS n_locations
FROM film_locations_sf
WHERE CurrentSupervisorDistricts IS NOT NULL
GROUP BY Title
HAVING COUNT(DISTINCT Locations) > 3
ORDER BY n_districts ASC, n_locations DESC;

-- # of different titles by year
SELECT ReleaseYear,
COUNT(DISTINCT Title) AS n_films
FROM film_locations_sf
GROUP BY ReleaseYear;

-- # of different titles by director
SELECT Director,
COUNT(DISTINCT Title) AS n_films
FROM film_locations_SF
GROUP BY Director
ORDER BY n_films DESC;

-- # of different titles by writer
SELECT Writer,
COUNT(DISTINCT Title) AS n_films
FROM film_locations_SF
GROUP BY Writer
ORDER BY n_films DESC;

-- # of different titles by actor
SELECT actor,
COUNT(DISTINCT Title) as n_films
FROM
(select actor1 AS actor,
    Title
from film_locations_SF
UNION
SELECT actor2 AS actor,
    Title
FROM film_locations_SF
UNION
SELECT actor3 AS actor,
    Title
FROM film_locations_SF) t
WHERE actor IS NOT NULL
GROUP BY actor
ORDER BY n_films DESC;

-- # of different titles by production company
SELECT productioncompany,
COUNT(DISTINCT Title) AS n_films
FROM film_locations_sf
GROUP BY productioncompany
ORDER BY n_films DESC;

-- # of different titles by distributor
SELECT distributor,
COUNT(DISTINCT Title) AS n_films
FROM film_locations_sf
GROUP BY distributor
ORDER BY n_films DESC;

-- Supervisor districts with the most titles filmed within
SELECT CurrentSupervisorDistricts,
COUNT(DISTINCT Title) AS n_films
FROM film_locations_sf
GROUP BY CurrentSupervisorDistricts
ORDER BY n_films DESC;

-- Supervisor districts with the most titles filmed within, by decade

SELECT CurrentSupervisorDistricts,
COUNT(DISTINCT Title) AS n_films
FROM film_locations_sf
WHERE ReleaseYear BETWEEN 1915 AND 1949
GROUP BY CurrentSupervisorDistricts
ORDER BY n_films DESC;

SELECT CurrentSupervisorDistricts,
COUNT(DISTINCT Title) AS n_films
FROM film_locations_sf
WHERE ReleaseYear BETWEEN 1950 AND 1959
GROUP BY CurrentSupervisorDistricts
ORDER BY n_films DESC;

SELECT CurrentSupervisorDistricts,
COUNT(DISTINCT Title) AS n_films
FROM film_locations_sf
WHERE ReleaseYear BETWEEN 1960 AND 1969
GROUP BY CurrentSupervisorDistricts
ORDER BY n_films DESC;

SELECT CurrentSupervisorDistricts,
COUNT(DISTINCT Title) AS n_films
FROM film_locations_sf
WHERE ReleaseYear BETWEEN 1970 AND 1979
GROUP BY CurrentSupervisorDistricts
ORDER BY n_films DESC;

SELECT CurrentSupervisorDistricts,
COUNT(DISTINCT Title) AS n_films
FROM film_locations_sf
WHERE ReleaseYear BETWEEN 1980 AND 1989
GROUP BY CurrentSupervisorDistricts
ORDER BY n_films DESC;

SELECT CurrentSupervisorDistricts,
COUNT(DISTINCT Title) AS n_films
FROM film_locations_sf
WHERE ReleaseYear BETWEEN 1990 AND 1999
GROUP BY CurrentSupervisorDistricts
ORDER BY n_films DESC;

SELECT CurrentSupervisorDistricts,
COUNT(DISTINCT Title) AS n_films
FROM film_locations_sf
WHERE ReleaseYear BETWEEN 2000 AND 2009
GROUP BY CurrentSupervisorDistricts
ORDER BY n_films DESC;

SELECT CurrentSupervisorDistricts,
COUNT(DISTINCT Title) AS n_films
FROM film_locations_sf
WHERE ReleaseYear BETWEEN 2010 AND 2023
GROUP BY CurrentSupervisorDistricts
ORDER BY n_films DESC;

-- Iconic SF landmarks outside of supervisor districts
SELECT Title, Locations
FROM film_locations_sf
WHERE currentsupervisordistricts IS NULL;
