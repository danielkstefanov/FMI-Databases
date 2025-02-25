--III.За базата от данни SHIPS
USE ships;

--1. Напишете заявка, която извежда името на корабите с водоизместимост над
--50000.

SELECT NAME
FROM SHIPS JOIN CLASSES
ON SHIPS.CLASS = CLASSES.CLASS
WHERE DISPLACEMENT > 50000

--2. Напишете заявка, която извежда имената, водоизместимостта и броя оръдия на
--всички кораби, участвали в битката при Guadalcanal.

SELECT NAME, DISPLACEMENT, NUMGUNS
FROM SHIPS JOIN CLASSES
ON SHIPS.CLASS = CLASSES.CLASS
JOIN OUTCOMES
ON SHIPS.NAME = OUTCOMES.SHIP AND BATTLE = 'Guadalcanal'

--3. Напишете заявка, която извежда имената на тези държави, които имат както
--бойни кораби, така и бойни крайцери.

SELECT C1.COUNTRY
FROM CLASSES AS C1 JOIN CLASSES AS C2
ON C1.TYPE = 'bb' AND C2.TYPE = 'bc'
WHERE C1.COUNTRY = C2.COUNTRY

--4. Напишете заявка, която извежда имената на тези кораби, които са били
--повредени в една битка, но по-късно са участвали в друга битка.

 SELECT O1.SHIP
 FROM OUTCOMES AS O1 JOIN BATTLES AS B1
 ON O1.BATTLE = B1.NAME
 JOIN OUTCOMES AS O2
 ON O1.SHIP = O2.SHIP AND O1.BATTLE != O2.BATTLE
 JOIN BATTLES AS B2
 ON O2.BATTLE = B2.NAME
 WHERE O1.RESULT = 'damaged' AND B1.DATE < B2.DATE
