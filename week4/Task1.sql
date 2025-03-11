--I. За базата от данни Movies
use movies;

--1. Напишете заявка, която извежда името на продуцента и имената на
--филмите, продуцирани от продуцента на филма ‘Star Wars’.

SELECT name, title 
FROM MOVIE 
JOIN MOVIEEXEC
ON MOVIEEXEC.CERT#  = MOVIE.PRODUCERC#
WHERE name IN (SELECT name FROM MOVIE 
join MOVIEEXEC
ON PRODUCERC# = CERT#
WHERE TITLE = 'Star Wars')

--2. Напишете заявка, която извежда имената на продуцентите на филмите, в
--които е участвал ‘Harrison Ford’.

SELECT NAME FROM MOVIEEXEC
WHERE CERT# IN (SELECT PRODUCERC# 
FROM MOVIE JOIN STARSIN
ON MOVIE.TITLE = STARSIN.MOVIETITLE AND MOVIE.YEAR = STARSIN.MOVIEYEAR
WHERE STARSIN.STARNAME = 'Harrison Ford')

--3. Напишете заявка, която извежда името на студиото и имената на
--актьорите, участвали във филми, произведени от това студио, подредени
--по име на студио.

SELECT DISTINCT MOVIE.STUDIONAME, STARSIN.STARNAME
FROM MOVIE JOIN STARSIN
ON MOVIE.TITLE = STARSIN.MOVIETITLE AND MOVIE.YEAR = STARSIN.MOVIEYEAR
ORDER BY MOVIE.STUDIONAME

--4. Напишете заявка, която извежда имената на актьорите, участвали във
--филми на продуценти с най-големи нетни активи.

SELECT STARSIN.STARNAME, MOVIEEXEC.NETWORTH, MOVIE.TITLE
FROM MOVIE JOIN STARSIN
ON MOVIE.TITLE = STARSIN.MOVIETITLE AND MOVIE.YEAR = STARSIN.MOVIEYEAR
JOIN MOVIEEXEC
ON MOVIE.PRODUCERC# = MOVIEEXEC.CERT#
WHERE MOVIEEXEC.CERT# IN (SELECT CERT# FROM MOVIEEXEC WHERE NETWORTH IN (SELECT MAX(NETWORTH) FROM MOVIEEXEC))

--5. Напишете заявка, която извежда имената на актьорите, които не са
--участвали в нито един филм.

SELECT NAME, MOVIETITLE
FROM MOVIESTAR LEFT JOIN STARSIN
ON MOVIESTAR.NAME = STARSIN.STARNAME
WHERE MOVIETITLE IS NULL