--I. За базата от данни MOVIES
USE movies;

--1. Напишете заявка, която извежда заглавие и година на всички филми, които са
--по-дълги от 120 минути и са снимани преди 2000 г. Ако дължината на филма е
--неизвестна, заглавието и годината на този филм също да се изведат.

SELECT TITLE, YEAR, LENGTH
FROM MOVIE
WHERE (LENGTH IS NULL OR LENGTH > 120) AND YEAR < 2000

--2. Напишете заявка, която извежда име и пол на всички актьори (мъже и жени),
--чието име започва с 'J' и са родени след 1948 година. Резултатът да бъде
--подреден по име в намаляващ ред.

-- Когато използваме LIKE 
		--% означава много на брой символи
		--_ означава точно един символ

SELECT NAME, GENDER
FROM MOVIESTAR
WHERE NAME LIKE 'J%' AND BIRTHDATE > 1948
ORDER BY NAME DESC

--3. Напишете заявка, която извежда име на студио и брой на актьорите,
--участвали във филми, които са създадени от това студио.

SELECT STUDIONAME, COUNT(DISTINCT STARNAME)
FROM MOVIE
JOIN STARSIN
ON MOVIE.TITLE = STARSIN.MOVIETITLE AND MOVIE.YEAR = STARSIN.MOVIEYEAR
GROUP BY STUDIONAME

--4. Напишете заявка, която за всеки актьор извежда име на актьора и броя на
--филмите, в които актьорът е участвал.

SELECT NAME, COUNT(MOVIETITLE) 
FROM MOVIESTAR
LEFT JOIN STARSIN
ON MOVIESTAR.NAME = STARSIN.STARNAME
GROUP BY NAME

--5. Напишете заявка, която за всяко студио извежда име на студиото и заглавие
--на филма, излязъл последно на екран за това студио.

SELECT STUDIONAME, TITLE, MOVIE.YEAR
FROM STUDIO
JOIN MOVIE
ON MOVIE.STUDIONAME = STUDIO.NAME
WHERE MOVIE.YEAR = (SELECT MAX(m1.YEAR)
    FROM MOVIE m1
    WHERE m1.STUDIONAME = STUDIO.NAME)
	
--6. Напишете заявка, която извежда името на най-младия актьор (мъж).

SELECT TOP 1 NAME
FROM MOVIESTAR
WHERE GENDER = 'm' AND BIRTHDATE = (SELECT MAX(BIRTHDATE) FROM MOVIESTAR WHERE GENDER = 'm')

--7. Напишете заявка, която извежда име на актьор и име на студио за тези
--актьори, участвали в най-много филми на това студио.

SELECT STUDIONAME, STARNAME, COUNT(STARNAME)
FROM MOVIE as m1
JOIN STARSIN
ON m1.TITLE = STARSIN.MOVIETITLE AND m1.YEAR = STARSIN.MOVIEYEAR
GROUP BY STUDIONAME, STARNAME
HAVING COUNT(STARNAME) >= ALL(SELECT COUNT(*) 
							  FROM MOVIE JOIN STARSIN 
							  ON MOVIE.TITLE = STARSIN.MOVIETITLE AND MOVIE.YEAR = STARSIN.MOVIEYEAR 
							  WHERE STUDIONAME = m1.STUDIONAME 
							  GROUP BY STARNAME) 

--8. Напишете заявка, която извежда заглавие и година на филма, и брой на
--актьорите, участвали в този филм за тези филми с повече от двама актьори.

SELECT TITLE, YEAR, COUNT(STARNAME) as ACTORS_COUNT
FROM MOVIE as m1
JOIN STARSIN
ON m1.TITLE = STARSIN.MOVIETITLE AND m1.YEAR = STARSIN.MOVIEYEAR
GROUP BY TITLE, YEAR
HAVING COUNT(STARNAME) > 2