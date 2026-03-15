CREATE TABLE directors (
    id          INT AUTO_INCREMENT PRIMARY KEY,
    director    VARCHAR(150) NOT NULL,
    nationality VARCHAR(50),
    birth_year  YEAR,
    active      BOOLEAN DEFAULT TRUE
);

CREATE TABLE movies (
    id           INT AUTO_INCREMENT PRIMARY KEY,
    title        VARCHAR(150) NOT NULL,
    genre        ENUM('action','comedy','drama','horror','sci-fi'),
    director     VARCHAR(150) NOT NULL,
    release_year YEAR,
    rating       DECIMAL(3,1),
    created_at   TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO directors (director, nationality, birth_year) VALUES
('Christopher Nolan', 'British',  1970),
('Rajkumar Hirani',   'Indian',   1962),
('Nitesh Tiwari',     'Indian',   1973),
('Sriram Raghavan',   'Indian',   1968),
('Jordan Peele',      'American', 1979),
('Anthony Russo',     'American', 1970),
('Frank Darabont',    'American', 1959),
('Steven Spielberg',  'American', 1946),  -- no movies in our table
('Quentin Tarantino', 'American', 1963);  -- no movies in our table

INSERT INTO movies (title, genre, director, release_year, rating) VALUES
('Inception',        'sci-fi', 'Christopher Nolan', 2010, 8.8),
('The Dark Knight',  'action', 'Christopher Nolan', 2008, 9.0),
('Interstellar',     'sci-fi', 'Christopher Nolan', 2014, 8.6),
('3 Idiots',         'comedy', 'Rajkumar Hirani',   2009, 8.4),
('Dangal',           'drama',  'Nitesh Tiwari',     2016, 8.3),
('Andhadhun',        'drama',  'Sriram Raghavan',   2018, 8.2),
('Get Out',          'horror', 'Jordan Peele',      2017, 7.7),
('Avengers Endgame', 'action', 'Anthony Russo',     2019, 8.4),
('The Shawshank',    'drama',  'Frank Darabont',    1994, 9.3);

--  INNER JOIN
--  Returns ONLY rows that have a match in BOTH tables.

-- Basic: all matched movies with director details
SELECT movies.title, movies.genre, movies.rating, directors.nationality, directors.birth_year FROM movies INNER JOIN directors ON movies.director = directors.director;

-- Only specific columns with aliases
SELECT movies.title AS movie_name, directors.director AS directed_by, directors.nationality AS country FROM movies INNER JOIN directors ON movies.director = directors.director;

-- Filter with WHERE: only drama movies
SELECT movies.title, movies.rating, directors.nationality FROM movies INNER JOIN directors ON movies.director = directors.director WHERE movies.genre = 'drama';

-- Filter: only Indian directors
SELECT movies.title, movies.genre, movies.rating, directors.director FROM movies INNER JOIN directors ON movies.director = directors.director WHERE directors.nationality = 'Indian';

-- Filter: movies rated above 8.5
SELECT movies.title, movies.rating, directors.director, directors.nationality FROM movies INNER JOIN directors ON movies.director = directors.director WHERE movies.rating > 8.5;

--  CROSS JOIN
--  Pairs EVERY row from movies with EVERY row from directors.
--  9 movies × 9 directors = 81 total combinations.

-- Basic: all combinations
SELECT movies.title, directors.director FROM movies CROSS JOIN directors;

-- Total combinations produced
SELECT COUNT(*) AS total_combinations FROM movies CROSS JOIN directors;

-- Filter: only action movies crossed with all directors
SELECT movies.title, movies.genre, directors.director, directors.nationality FROM movies CROSS JOIN directors WHERE movies.genre = 'action';

-- Filter: only American directors paired with all movies
SELECT movies.title, movies.rating, directors.director FROM movies CROSS JOIN directors WHERE directors.nationality = 'American';

-- Filter: highly rated movies crossed with all directors
SELECT movies.title, movies.rating, directors.director FROM movies CROSS JOIN directors WHERE movies.rating >= 9.0;

-- Filter: Indian directors crossed with drama movies
SELECT movies.title, movies.genre, directors.director, directors.nationality FROM movies CROSS JOIN directors WHERE directors.nationality = 'Indian' AND movies.genre = 'drama';
