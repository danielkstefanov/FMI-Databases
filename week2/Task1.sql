--I.За базата от данни Movies
USE MOVIES

--1. Напишете заявка, която извежда имената на актьорите мъже, участвали във
--филма The Usual Suspects.

SELECT NAME
FROM STARSIN JOIN MOVIESTAR
ON STARNAME = NAME
WHERE GENDER='M' AND MOVIETITLE='The Usual Suspects'

--2. Напишете заявка, която извежда имената на актьорите, участвали във филми от
--1995, продуцирани от студио MGM.

SELECT STARNAME
FROM STARSIN JOIN MOVIE
ON MOVIETITLE = TITLE AND MOVIEYEAR = YEAR
WHERE MOVIEYEAR = 1995 AND STUDIONAME = 'MGM'

--3. Напишете заявка, която извежда имената на продуцентите, които са
--продуцирали филми на студио MGM.

SELECT DISTINCT NAME
FROM MOVIEEXEC JOIN MOVIE
ON CERT# = PRODUCERC#
WHERE STUDIONAME = 'MGM'

--4. Напишете заявка, която извежда имената на всички филми с дължина, поголяма от дължината на филма Star Wars.

SELECT MV1.TITLE
FROM MOVIE AS MV1 JOIN MOVIE AS MV2
ON MV2.TITLE = 'Star Wars'
WHERE MV1.LENGTH > MV2.LENGTH

--5. Напишете заявка, която извежда имената на продуцентите с нетни активи поголеми от тези на Stephen Spielberg.

SELECT MVE1.NAME
FROM MOVIEEXEC AS MVE1 JOIN MOVIEEXEC AS MVE2
ON MVE2.NAME = 'Stephen Spielberg'
WHERE MVE1.NETWORTH > MVE2.NETWORTH
