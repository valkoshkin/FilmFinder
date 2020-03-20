CREATE TABLE Person
(
    id_person   SERIAL PRIMARY KEY,
    first_name  VARCHAR(50) NOT NULL,
    second_name VARCHAR(50) NOT NULL,
    birthday    DATE        NOT NULL,
    country     VARCHAR(50) NOT NULL
);
CREATE TABLE Serial
(
    id_serial       SERIAL PRIMARY KEY,
    title           VARCHAR(100) NOT NULL,
    year_start      INTEGER      NOT NULL,
    year_finish     INTEGER      NOT NULL,
    num_of_episodes INTEGER      NOT NULL,
    num_of_seasons  INTEGER      NOT NULL,
    imdb            REAL         NOT NULL
);

CREATE TABLE Film
(
    id_film    SERIAL PRIMARY KEY,
    title      VARCHAR(100) NOT NULL,
    issue_year INTEGER      NOT NULL,
    imdb       REAL         NOT NULL,
    length     INTEGER      NOT NULL
);

CREATE TABLE Genre
(
    id_genre   SERIAL PRIMARY KEY,
    name_genre VARCHAR(50)
);

CREATE TABLE Position
(
    id_position   SERIAL PRIMARY KEY,
    name_position VARCHAR(50)
);

CREATE TABLE Film_Person
(
    id_film     SERIAL references Film (id_film) ON DELETE CASCADE ON UPDATE CASCADE,
    id_person   SERIAL references Person (id_person) ON DELETE CASCADE ON UPDATE CASCADE,
    id_position SERIAL references Position (id_position) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Film_Genre
(
    id_film  SERIAL references Film (id_film) ON DELETE CASCADE ON UPDATE CASCADE,
    id_genre SERIAL references Genre (id_genre) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Serial_Genre
(
    id_serial SERIAL references Serial (id_serial) ON DELETE CASCADE ON UPDATE CASCADE,
    id_genre  SERIAL references Genre (id_genre) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Serial_Person
(
    id_serial   SERIAL references Serial (id_serial) ON DELETE CASCADE ON UPDATE CASCADE,
    id_person   SERIAL references Person (id_person) ON DELETE CASCADE ON UPDATE CASCADE,
    id_position SERIAL references Position (id_position) ON DELETE CASCADE ON UPDATE CASCADE
);
