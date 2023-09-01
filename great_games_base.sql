CREATE DATABASE GreatGamesBase;
USE GreatGamesBase;

CREATE TABLE people (
	people_id INT NOT NULL auto_increment PRIMARY KEY,
    full_name VARCHAR(30) NOT NULL,
    gender VARCHAR(10),
    nationality VARCHAR(10),
    birthday DATE,
    profession INT
);

CREATE TABLE profession (
	profession_id INT NOT NULL auto_increment PRIMARY KEY,
    title VARCHAR(30) NOT NULL,
    descrip VARCHAR(100) 
);

describe profession;
describe people;

CREATE TABLE people_profession (
	peop_prof_id INT NOT NULL auto_increment PRIMARY KEY,
    person_id INT NOT NULL, 
    profession_id INT NOT NULL,
    FOREIGN KEY(person_id) REFERENCES people(people_id) ON DELETE CASCADE,
    FOREIGN KEY(profession_id) REFERENCES profession(profession_id) ON DELETE CASCADE
);

describe people_profession;

INSERT INTO people(full_name, gender, nationality, birthday) VALUES("Hideo Kojima", "Male", "Japan", '1963-08-24');

SELECT * FROM people;
SELECT * FROM profession;
SELECT * FROM people_profession;
SELECT * FROM Country;
SELECT * FROM developer;
SELECT * FROM dev_people;
SELECT * FROM publisher;
SELECT * FROM pub_people;
SELECT * FROM platform;
SELECT * FROM screenshots;
SELECT * FROM games;
SELECT * FROM tags;
SELECT * FROM games_tags;
SELECT * FROM games_genre;
SELECT * FROM games_platform;
SELECT * FROM games_people;



INSERT INTO profession(title, profession_description) VALUES("Game Designer", "Person responsible for overall direction, structure and experience of the game. Equivalent to movie director.");

UPDATE profession SET profession_description = "Person responsible for overall direction, structure and experience of the game. Equivalent to movie director." WHERE profession_id = 1;
UPDATE people SET nationality = 1 WHERE people_id = 1;
UPDATE country SET country_name = "Britain" WHERE country_name = "England";

ALTER TABLE profession RENAME COLUMN descrip TO profession_description;
ALTER TABLE profession MODIFY COLUMN profession_description VARCHAR(255);

ALTER TABLE people add COLUMN nationality INT;

ALTER TABLE people DROP COLUMN nationality;

INSERT INTO people_profession(peop_prof_id, person_id, profession_id) VALUES(1, 1, 1);

DELETE FROM people_profession
WHERE peop_prof_id = 1;

DELETE FROM profession
WHERE profession_id = 1;


SELECT full_name FROM people WHERE people_id = (
	SELECT person_id FROM people_profession WHERE profession_id = (
		SELECT profession_id FROM profession WHERE title = "Game Designer")
    );
    
SELECT full_name FROM people
JOIN people_profession ON people_id = person_id
JOIN profession ON people_profession.profession_id = profession.profession_id;

CREATE TABLE developer (
	developer_id INT NOT NULL auto_increment PRIMARY KEY,
    title VARCHAR(20),
    country int,
    founded DATE,
    closed DATE,
    FOREIGN KEY(country) REFERENCES country(country_id) ON DELETE SET NULL
);

CREATE TABLE country (
	country_id INT NOT NULL auto_increment PRIMARY KEY,
    country_name VARCHAR(30)
);

INSERT INTO country(country_name) VALUES("Finland");

ALTER TABLE people
ADD FOREIGN KEY(nationality)
REFERENCES country(country_id)
ON DELETE SET NULL;

CREATE TABLE dev_people (
	dev_people_id INT NOT NULL auto_increment PRIMARY KEY,
    person_id INT NOT NULL, 
    developer_id INT NOT NULL,
    FOREIGN KEY(person_id) REFERENCES people(people_id) ON DELETE CASCADE,
    FOREIGN KEY(developer_id) REFERENCES developer(developer_id) ON DELETE CASCADE
);

CREATE TABLE publisher (
	developer_id INT NOT NULL auto_increment PRIMARY KEY,
    title VARCHAR(20),
    country int,
    founded DATE,
    closed DATE,
    FOREIGN KEY(country) REFERENCES country(country_id) ON DELETE SET NULL
);

ALTER TABLE publisher rename column developer_id to publisher_id;

CREATE TABLE pub_people (
	pub_people_id INT NOT NULL auto_increment PRIMARY KEY,
    person_id INT NOT NULL, 
    publisher_id INT NOT NULL,
    FOREIGN KEY(person_id) REFERENCES people(people_id) ON DELETE CASCADE,
    FOREIGN KEY(publisher_id) REFERENCES publisher(publisher_id) ON DELETE CASCADE
);

CREATE TABLE platform (
	platform_id INT NOT NULL auto_increment PRIMARY KEY,
    platform_name VARCHAR(20),
    company int,
    generation int,
    released DATE,
    discontinued DATE,
    FOREIGN KEY(company) REFERENCES publisher(publisher_id) ON DELETE SET NULL
);
DROP TABLE platform;
CREATE TABLE genre (
	genre_id INT NOT NULL auto_increment PRIMARY KEY,
    genre_name VARCHAR(20) NOT NULL,
    subgenre_of int,
    genre_description VARCHAR(255)
);

ALTER TABLE genre add FOREIGN KEY(subgenre_of) REFERENCES genre(genre_id) ON DELETE CASCADE;


INSERT INTO genre(genre_name) VALUES("RPG");
INSERT INTO genre(genre_name, subgenre_of) VALUES("JRPG", 1);
DELETE FROM genre
WHERE genre_id = 1;

CREATE TABLE games (
	game_id INT NOT NULL auto_increment PRIMARY KEY,
    game_title VARCHAR(50) NOT NULL,
    cover VARCHAR(75),
    release_date DATE,
    game_description VARCHAR(400),
    series VARCHAR(50),
    score int,
    developer int,
    publisher int,
    main_platform int,
    FOREIGN KEY(developer) REFERENCES developer(developer_id) ON DELETE SET NULL,
    FOREIGN KEY(publisher) REFERENCES publisher(publisher_id) ON DELETE SET NULL,
    FOREIGN KEY(main_platform) REFERENCES platform(platform_id) ON DELETE SET NULL
);

CREATE TABLE games_people (
	game_people_id INT NOT NULL auto_increment PRIMARY KEY,
    person_id INT NOT NULL, 
    game_id INT NOT NULL,
    FOREIGN KEY(person_id) REFERENCES people(people_id) ON DELETE CASCADE,
    FOREIGN KEY(game_id) REFERENCES games(game_id) ON DELETE CASCADE
);

CREATE TABLE games_platform (
	game_platform_id INT NOT NULL auto_increment PRIMARY KEY,
    platform_id INT NOT NULL, 
    game_id INT NOT NULL,
    FOREIGN KEY(platform_id) REFERENCES platform(platform_id) ON DELETE CASCADE,
    FOREIGN KEY(game_id) REFERENCES games(game_id) ON DELETE CASCADE
);

CREATE TABLE games_genre (
	game_genre_id INT NOT NULL auto_increment PRIMARY KEY,
    genre_id INT NOT NULL, 
    game_id INT NOT NULL,
    FOREIGN KEY(genre_id) REFERENCES genre(genre_id) ON DELETE CASCADE,
    FOREIGN KEY(game_id) REFERENCES games(game_id) ON DELETE CASCADE
);

CREATE TABLE screenshots (
	screenshot_id INT NOT NULL auto_increment PRIMARY KEY,
    screenshot_path VARCHAR(75),
    game_id int,
    FOREIGN KEY(game_id) REFERENCES games(game_id) ON DELETE CASCADE
);

CREATE TABLE tags (
	tag_id INT NOT NULL auto_increment PRIMARY KEY,
    tag_title VARCHAR(60)
);

CREATE TABLE games_tags (
	game_tag_id INT NOT NULL auto_increment PRIMARY KEY,
    tag_id INT NOT NULL, 
    game_id INT NOT NULL,
    FOREIGN KEY(tag_id) REFERENCES tags(tag_id) ON DELETE CASCADE,
    FOREIGN KEY(game_id) REFERENCES games(game_id) ON DELETE CASCADE
);



