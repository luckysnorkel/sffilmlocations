-- # of different filming locations
SELECT COUNT(DISTINCT Locations)
FROM film_locations_sf;

-- # of different films
SELECT COUNT(DISTINCT Title)
FROM film_locations_sf;

-- Films with the most distinct filming locations
SELECT Title, 
COUNT(DISTINCT Locations) as n_locations
FROM film_locations_sf
GROUP BY Title
ORDER BY n_locations DESC;

-- # of different films by year
SELECT ReleaseYear,
COUNT(DISTINCT Title) AS n_films
FROM film_locations_sf
GROUP BY ReleaseYear;

-- # of different films by director
SELECT Director,
COUNT(DISTINCT Title) AS n_films
FROM film_locations_SF
GROUP BY Director
ORDER BY n_films DESC;

-- # of different films by writer
SELECT Writer,
COUNT(DISTINCT Title) AS n_films
FROM film_locations_SF
GROUP BY Writer
ORDER BY n_films DESC;

-- # of different films by actor
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

-- # of different films by production company
SELECT productioncompany,
COUNT(DISTINCT Title) AS n_films
FROM film_locations_sf
GROUP BY productioncompany
ORDER BY n_films DESC;

-- # of different films by distributor
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

-- Iconic SF landmarks outside of supervisor districts
SELECT Title, Locations
FROM film_locations_sf
WHERE currentsupervisordistricts IS NULL;