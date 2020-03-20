--Вывести все фильмы, соотетствующие заданной личности и заданной должности
select distinct title, issue_year, imdb, length
from film
where id_film in
      (select id_film
       from film_person
       where id_position in
             (select id_position
              from position
              where name_position = 'Актер')
         and id_person = 1;

--Вывести все сериалы, соотетствующие заданной личности
select distinct title, year_start, year_finish, num_of_episodes, num_of_seasons, imdb
from serial
where id_serial in
      (select id_serial
       from serial_person
       where id_person in
             (select id_person
              from person
              where first_name = 'Кристофер'));

--Вывести всех актеров, соответствующих заданному фильму
select distinct first_name, second_name, birthday, country
from person
where id_person in
      (select id_person
       from film_person
       where id_film in
             (select id_film
              from film
              where title = 'Начало'));

--Вывести всех актеров, соответствующих заданному сериалу
select distinct first_name, second_name, birthday, country
from person
where id_person in
      (select id_person
       from serial_person
       where id_serial in
             (select id_serial
              from serial
              where title = 'Друзья'));

--Вывести все фильмы заданной личности с указанием должности
select distinct title, issue_year, name_position
from film
         join film_person on film.id_film = film_person.id_film
         join position on film_person.id_position = position.id_position
where id_person = '1'

--подсчитать количество фильмов, в которых личность принимала участие
select count(*)
from (select distinct id_person, id_film from film_person where id_person = 1) as numOfProjects
