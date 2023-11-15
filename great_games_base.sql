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

CREATE TABLE subgenre_relation (
	subgenre_relation_id INT NOT NULL auto_increment PRIMARY KEY,
    subgenre_id INT NOT NULL, 
    genre_id INT NOT NULL,
    FOREIGN KEY(subgenre_id) REFERENCES genre(genre_id) ON DELETE CASCADE,
    FOREIGN KEY(genre_id) REFERENCES genre(genre_id) ON DELETE CASCADE
);

describe people_profession;

INSERT INTO people(full_name, gender, nationality, birthday) VALUES("Hideo Kojima", "Male", "Japan", '1963-08-24');
INSERT INTO Country(country_name) VALUES ("Ireland");
SELECT full_name FROM people WHERE full_name = 'Hideo Kojima';

DESCRIBE platform;
DELETE FROM publisher WHERE title = "BVV";

describe games_people;
describe games;
delete from games where game_id = 28;

Describe People;
update profession set profession_description = "profession_descriptions/Game Designer_desc.txt" where profession_id=1;
update games_people set profession_id = 1 where game_people_id = 15;

SELECT profession_id from games_people where game_id = 29 and profession_id IS NOT NULL;

#selecting designer and his profession on a given game_id
SELECT p.full_name, pro.title 
FROM people as p
join games_people as gp on p.people_id = gp.person_id
left join profession as pro on pro.profession_id = gp.profession_id
where gp.game_id = 29;

insert INTO games_people (person_id, game_id, profession_id) VALUES (5, 21, 4);
DELETE from games where game_id = 34;
UPDATE people set birthday = "1961-08-13" where people_id = 12;

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
SELECT * FROM genre;
SELECT * FROM games_tags;
SELECT * FROM games_genre;
SELECT * FROM games_platform;
SELECT * FROM games_people;
SELECT * FROM subgenre_relation;


SELECT game_title, row_number() OVER (order by game_id DESC) as RowNum  FROM games;

SELECT game_title, RowNum from (
SELECT game_title, row_number() OVER () as RowNum  FROM games) as t1
WHERE RowNum > 5 and RowNum < 10;

SELECT game_title FROM games where game_title LIKE "%th%" limit 2;

update games set release_date = "1986-05-27" where game_id = 39;

ALTER TABLE people ADD COLUMN deceased date;

DELETE FROM genre where genre_id = 20;
DELETE FROM tags WHERE tag_id = 2;
update tags set tag_title = "Zelda-like"  where tag_id = 14;

INSERT INTO games_tags(tag_id, game_id) VALUES(3, (SELECT DISTINCT game_id  FROM games WHERE game_title = "The Legend of Zelda"));

SELECT DISTINCT genre_name FROM genre WHERE genre_id = 8;

INSERT INTO games_people(person_id, game_id, profession_id) VALUES(10, 31, 2);

SELECT person_id FROM dev_people WHERE person_id = 1 AND developer_id = 1;

delete from games where game_id = 30;
INSERT INTO publisher (title, country, founded, closed) VALUES ("BVV", 1, "1963-08-24", NULL);
INSERT INTO profession(title, profession_description) VALUES("Game Designer", "Person responsible for overall direction, structure and experience of the game. Equivalent to movie director.");

UPDATE profession SET profession_description = "Person responsible for overall direction, structure and experience of the game. Equivalent to movie director." WHERE profession_id = 1;
UPDATE people SET nationality = 1 WHERE people_id = 1;
UPDATE platform SET released = "1988-10-29" WHERE platform_id = "4";

UPDATE games SET game_description = "game_descriptions/Metal Gear Solid_desc.txt" WHERE game_id = 19;

ALTER TABLE profession RENAME COLUMN descrip TO profession_description;
ALTER TABLE screenshots MODIFY COLUMN screenshot_path VARCHAR(200);

ALTER TABLE games_people add COLUMN profession_id INT;
ALTER TABLE games_people add FOREIGN KEY(profession_id) REFERENCES profession(profession_id) ON DELETE SET NULL;

ALTER TABLE genre MODIFY COLUMN genre_name VARCHAR(300);

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

INSERT INTO country(country_name) VALUES("Canada");

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

SELECT title FROM publisher WHERE title like "%o%" LIMIT 10;

Select title from(
select title, row_number() OVER() as rownum from publisher where title LIKE "b") as t1
where rownum > 4 and rownum < 10;



