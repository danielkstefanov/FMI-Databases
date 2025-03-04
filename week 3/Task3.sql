--III.За базата от данни SHIPS
USE ships;

--1. Напишете заявка, която извежда страните, чиито кораби са с най-голям
--брой оръдия.

SELECT DISTINCT COUNTRY
FROM CLASSES
WHERE EXISTS (SELECT * FROM SHIPS WHERE SHIPS.CLASS = CLASSES.CLASS) AND 
NUMGUNS = (SELECT TOP 1 NUMGUNS FROM CLASSES ORDER BY NUMGUNS DESC)

--2. Напишете заявка, която извежда класовете, за които поне един от
--корабите е потънал в битка.

SELECT CLASS 
FROM CLASSES
WHERE CLASS IN (SELECT CLASS FROM SHIPS WHERE NAME IN (SELECT SHIP FROM OUTCOMES WHERE RESULT = 'sunk'))

--3. Напишете заявка, която извежда името и класа на корабите с 16 инчови
--оръдия.

SELECT SHIPS.NAME, CLASSES.CLASS
FROM SHIPS INNER JOIN CLASSES 
ON SHIPS.CLASS = CLASSES.CLASS
WHERE BORE = 16

--4. Напишете заявка, която извежда имената на битките, в които са
--участвали кораби от клас ‘Kongo’.

SELECT BATTLE
FROM OUTCOMES
WHERE EXISTS (SELECT * FROM SHIPS WHERE CLASS = 'Kongo' AND NAME = OUTCOMES.SHIP)

--5. Напишете заявка, която извежда класа и името на корабите, чиито брой
--оръдия е по-голям или равен на този на корабите със същия калибър
--оръдия.

SELECT CLASS, NAME
FROM SHIPS
WHERE CLASS IN (SELECT CLASS FROM CLASSES AS C WHERE C.NUMGUNS >= ALL (SELECT NUMGUNS FROM CLASSES WHERE BORE = C.BORE))