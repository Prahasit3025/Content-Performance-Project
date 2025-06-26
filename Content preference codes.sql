-- Count of Movies and TV Shows
SELECT type, COUNT(*) AS total_titles
FROM netflix_titles
GROUP BY type;

-- Titles Released in 2022
SELECT title, type, country 
FROM netflix_titles 
WHERE release_year = 2022;

-- Top 5 Countries by Content Count
SELECT country, COUNT(*) AS total_titles 
FROM netflix_titles 
WHERE country IS NOT NULL 
GROUP BY country 
ORDER BY total_titles DESC 
LIMIT 5;

-- List All Unique Ratings
SELECT DISTINCT rating
FROM netflix_titles
WHERE rating IS NOT NULL;

-- Top 5 Ratings with Most Content
SELECT rating, COUNT(*) AS total_titles
FROM netflix_titles
GROUP BY rating
ORDER BY total_titles DESC
LIMIT 5;


-- Titles Containing a Specific Genre (e.g., ‘Comedy’)
SELECT title, type, release_year
FROM netflix_titles
WHERE listed_in LIKE '%Comedy%';

-- Top 10 Countries by Number of Titles
SELECT country, COUNT(*) AS total_titles
FROM netflix_titles
WHERE country IS NOT NULL
GROUP BY country
ORDER BY total_titles DESC
LIMIT 10;

-- Number of Titles Added per Year
SELECT release_year, COUNT(*) AS titles_released
FROM netflix_titles
GROUP BY release_year
ORDER BY release_year;

-- Most Common Ratings
SELECT rating, COUNT(*) AS total
FROM netflix_titles
GROUP BY rating
ORDER BY total DESC;

-- Average Movie Duration (in minutes)
SELECT AVG(CAST(SUBSTRING_INDEX(duration, ' ', 1) AS UNSIGNED)) AS avg_duration
FROM netflix_titles
WHERE type = 'Movie' AND duration LIKE '%min%';

-- Top 10 Directors by Number of Titles
SELECT director, COUNT(*) AS total_titles
FROM netflix_titles
WHERE director IS NOT NULL AND director <> ''
GROUP BY director
ORDER BY total_titles DESC
LIMIT 10;

-- Titles Added After 2020 

SELECT title,monthname(date_added) ,Year(date_added)
FROM netflix_titles
WHERE date_added > (
    SELECT MIN(date_added)
    FROM netflix_titles
    WHERE YEAR(date_added) = 2018
);

-- Top 5 Countries by Movies Released After 2015
SELECT country, total_movies
FROM (
    SELECT country, COUNT(*) AS total_movies
    FROM netflix_titles
    WHERE type = 'Movie' AND release_year > 2015 AND country IS NOT NULL
    GROUP BY country
) AS recent_movies
ORDER BY total_movies DESC
LIMIT 10;

-- Top 5 Most Common Genres
SELECT genre, COUNT(*) AS total
FROM (
    SELECT TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(listed_in, ',', n.n), ',', -1)) AS genre
    FROM netflix_titles
    JOIN (
        SELECT 1 AS n UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4
    ) n ON CHAR_LENGTH(listed_in) - CHAR_LENGTH(REPLACE(listed_in, ',', '')) >= n.n - 1
) AS genre_table
GROUP BY genre
ORDER BY total DESC
LIMIT 5;

-- Genre and Rating Combination (for Analysis)
SELECT TRIM(SUBSTRING_INDEX(listed_in, ',', 1)) AS genre, rating, COUNT(*) AS total
FROM netflix_titles
GROUP BY genre, rating
ORDER BY total DESC;


