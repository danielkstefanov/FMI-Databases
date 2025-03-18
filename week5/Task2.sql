--II. За базата от данни SHIPS
USE ships;

--1. Напишете заявка, която извежда броя на класовете бойни кораби.

SELECT COUNT(TYPE)
FROM CLASSES
WHERE TYPE = 'bb'

--2. Напишете заявка, която извежда средния брой оръдия за всеки клас боен кораб.

SELECT CLASS, AVG(NUMGUNS) AS AVG_NUMGUNS_COUNT
FROM CLASSES
WHERE TYPE = 'bb'
GROUP BY CLASS

--3. Напишете заявка, която извежда средния брой оръдия за всички бойни кораби.

SELECT AVG(NUMGUNS) AS AVG_NUMGUNS_COUNT
FROM CLASSES
WHERE TYPE = 'bb'

--4. Напишете заявка, която извежда за всеки клас първата и последната година, в
--която кораб от съответния клас е пуснат на вода.

SELECT CLASS, MIN(LAUNCHED) AS FIRST_YEAR, MAX(LAUNCHED) AS LAST_YEAR
FROM SHIPS
GROUP BY CLASS

--5. Напишете заявка, която извежда броя на корабите, потънали в битка според
--класа.

SELECT SHIPS.CLASS, COUNT(SHIPS.NAME) AS SUNK_COUNT
FROM SHIPS JOIN OUTCOMES
ON SHIPS.NAME = OUTCOMES.SHIP
WHERE OUTCOMES.RESULT = 'sunk'
GROUP BY SHIPS.CLASS

--6. Напишете заявка, която извежда броя на корабите, потънали в битка според
--класа, за тези класове с повече от 2 кораба.

SELECT SHIPS.CLASS, COUNT(SHIPS.NAME) AS SUNK_COUNT
FROM SHIPS JOIN OUTCOMES
ON SHIPS.NAME = OUTCOMES.SHIP
WHERE OUTCOMES.RESULT = 'sunk'
GROUP BY SHIPS.CLASS
HAVING SHIPS.CLASS IN
       (SELECT CLASSES.CLASS
        FROM CLASSES JOIN SHIPS
                          ON CLASSES.CLASS = SHIPS.CLASS
        GROUP BY CLASSES.CLASS
        HAVING COUNT(SHIPS.NAME) > 2)

--7. Напишете заявка, която извежда средния калибър на оръдията на корабите за
--всяка страна.

SELECT CLASSES.COUNTRY, CONVERT(DECIMAL(9,2), AVG(CLASSES.BORE)) AS AVG_BORE
FROM SHIPS JOIN CLASSES
ON SHIPS.CLASS = CLASSES.CLASS
GROUP BY CLASSES.COUNTRY