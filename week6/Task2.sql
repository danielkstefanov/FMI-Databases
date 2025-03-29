--II. За базата от данни SHIPS
USE ships;

--1. Напишете заявка, която извежда имената на всички кораби без повторения,
--които са участвали в поне една битка и чиито имена започват с C или K.

SELECT DISTINCT SHIP
FROM OUTCOMES
WHERE SHIP LIKE 'C%' OR SHIP LIKE 'K%'

--2. Напишете заявка, която извежда име и държава на всички кораби, които
--никога не са потъвали в битка (може и да не са участвали).

SELECT SHIPS.NAME, CLASSES.COUNTRY
FROM SHIPS JOIN CLASSES
ON SHIPS.CLASS = CLASSES.CLASS
LEFT JOIN OUTCOMES
ON SHIPS.NAME = OUTCOMES.SHIP AND OUTCOMES.RESULT = 'sunk'
WHERE OUTCOMES.RESULT IS NULL

--3. Напишете заявка, която извежда държавата и броя на потъналите кораби за
--тази държава. Държави, които нямат кораби или имат кораб, но той не е
--участвал в битка, също да бъдат изведени.

SELECT CLASSES.COUNTRY, COUNT(OUTCOMES.RESULT)
FROM SHIPS RIGHT JOIN CLASSES
ON SHIPS.CLASS = CLASSES.CLASS
LEFT JOIN OUTCOMES
ON OUTCOMES.SHIP = SHIPS.NAME AND OUTCOMES.RESULT = 'sunk'
GROUP BY CLASSES.COUNTRY

--4. Напишете заявка, която извежда име на битките, които са по-мащабни (с
--повече участващи кораби) от битката при Guadalcanal.

SELECT OUTCOMES.BATTLE
FROM OUTCOMES 
GROUP BY OUTCOMES.BATTLE
HAVING COUNT(OUTCOMES.SHIP) > (SELECT COUNT(OUTCOMES.SHIP)
							   FROM OUTCOMES 
							   WHERE OUTCOMES.BATTLE = 'Guadalcanal')

--5. Напишете заявка, която извежда име на битките, които са по-мащабни (с
--повече участващи страни) от битката при Surigao Strait.

SELECT OUTCOMES.BATTLE, COUNT(DISTINCT CLASSES.COUNTRY)
FROM OUTCOMES 
JOIN SHIPS
ON OUTCOMES.SHIP = SHIPS.NAME
JOIN CLASSES
ON SHIPS.CLASS = CLASSES.CLASS
GROUP BY OUTCOMES.BATTLE
HAVING COUNT(DISTINCT CLASSES.COUNTRY) > (SELECT COUNT(DISTINCT CLASSES.COUNTRY)
										  FROM OUTCOMES 
										  JOIN SHIPS
										  ON OUTCOMES.SHIP = SHIPS.NAME
										  JOIN CLASSES
										  ON SHIPS.CLASS = CLASSES.CLASS
										  WHERE OUTCOMES.BATTLE = 'Surigao Strait'
										  GROUP BY OUTCOMES.BATTLE)

--6. Напишете заявка, която извежда имената на най-леките кораби с най-много
--оръдия.

SELECT s1.NAME, CLASSES.DISPLACEMENT, CLASSES.NUMGUNS
FROM SHIPS as s1
JOIN CLASSES
ON s1.CLASS = CLASSES.CLASS
WHERE CLASSES.DISPLACEMENT <= ALL (SELECT CLASSES.DISPLACEMENT
								   FROM SHIPS
								   JOIN CLASSES
								   ON SHIPS.CLASS = CLASSES.CLASS)
	   AND CLASSES.NUMGUNS >= ALL (SELECT CLASSES.NUMGUNS
								   FROM SHIPS
								   JOIN CLASSES
								   ON SHIPS.CLASS = CLASSES.CLASS
								   WHERE SHIPS.NAME = s1.NAME)

--7. Изведете броя на корабите, които са били увредени в битка, но са били
--поправени и по-късно са победили в друга битка.

SELECT COUNT(*) FROM
(SELECT *
FROM OUTCOMES
JOIN BATTLES
ON BATTLES.NAME = OUTCOMES.BATTLE
WHERE OUTCOMES.RESULT = 'damaged') as t1
JOIN (SELECT *
FROM OUTCOMES
JOIN BATTLES
ON BATTLES.NAME = OUTCOMES.BATTLE
WHERE OUTCOMES.RESULT = 'ok') as t2
ON t1.SHIP = t2.SHIP
WHERE t1.DATE < t2.DATE

--8. Изведете име на корабите, които са били увредени в битка, но са били
--поправени и по-късно са победили в по-мащабна битка (с повече кораби).SELECT t1.SHIP FROM
(SELECT *
FROM OUTCOMES
JOIN BATTLES
ON BATTLES.NAME = OUTCOMES.BATTLE
WHERE OUTCOMES.RESULT = 'damaged') as t1
JOIN (SELECT *
FROM OUTCOMES
JOIN BATTLES
ON BATTLES.NAME = OUTCOMES.BATTLE
WHERE OUTCOMES.RESULT = 'ok') as t2
ON t1.SHIP = t2.SHIP
WHERE (SELECT COUNT(*) FROM OUTCOMES WHERE BATTLE = t1.BATTLE) < (SELECT COUNT(*) FROM OUTCOMES WHERE BATTLE = t2.BATTLE)