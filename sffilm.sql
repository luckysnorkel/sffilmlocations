--- Part I: General film location stats
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

-- Location diversity by year
SELECT
    ReleaseYear,
    Title,
    COUNT(DISTINCT CurrentSupervisorDistricts) AS DistrictsDiversity
FROM
    film_locations_sf
GROUP BY
    ReleaseYear, Title
ORDER BY
    ReleaseYear ASC, DistrictsDiversity DESC;
	
-- Change in average diversity
SELECT
    ReleaseYear,
    AVG(DistrictsDiversity) AS AvgDistrictsDiversity
FROM (
    SELECT
        ReleaseYear,
        Title,
        COUNT(DISTINCT CurrentSupervisorDistricts) AS DistrictsDiversity
    FROM
        film_locations_sf
    GROUP BY
        ReleaseYear, Title
) AS YearlyDiversity
GROUP BY
    ReleaseYear
ORDER BY
    ReleaseYear ASC;


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

--- Part II: Filming location data vs SF district data


--- Part III: Filming location data vs film data
-- Joining with Kaggle film dataset
CREATE TABLE sf_film_stats AS
SELECT DISTINCT a.title, 
	b.imdb_id, 
	a.releaseyear, 
	b.release_date, 
	b.budget, 
	b.revenue, 
	b.popularity,
	b.vote_average,
	b.overview
FROM film_locations_sf a
LEFT JOIN tmdb_movie_dataset b
ON a.title = b.title
WHERE SUBSTRING(b.release_date, 1, 4) = CAST(a.releaseyear AS varchar)
OR SUBSTRING(b.release_date, 1, 4) = CAST((a.releaseyear + 1) AS varchar);

-- Creating table of diversity stats per title
CREATE TABLE sf_diversity AS
SELECT Title,
    COUNT(DISTINCT CurrentSupervisorDistricts) AS DistrictsDiversity
FROM film_locations_sf
GROUP BY Title;

-- Joining new tables and analyzing correlations
SELECT a.title,
	a.budget,
	a.revenue,
	a.popularity,
	a.vote_average,
	b.districtsdiversity,
	a.overview
FROM sf_film_stats a
JOIN sf_diversity b
ON a.title = b.title
WHERE vote_average != 0
ORDER BY popularity DESC;
