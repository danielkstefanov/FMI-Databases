--II.За базата от данни PC
USE pc;

--1. Напишете заявка, която извежда производителите на персонални
--компютри с честота над 500.

SELECT maker 
FROM product
WHERE model IN (SELECT model FROM pc WHERE speed > 500)

--2. Напишете заявка, която извежда код, модел и цена на принтерите с найвисока цена.

SELECT code, model, price 
FROM printer
WHERE price >=ALL (SELECT price FROM printer)

--3. Напишете заявка, която извежда лаптопите, чиято честота е по-ниска от
--честотата на всички персонални компютри.

SELECT * 
FROM laptop
WHERE speed <ALL (SELECT speed FROM pc)

--4. Напишете заявка, която извежда модела и цената на продукта (PC,
--лаптоп или принтер) с най-висока цена.

SELECT TOP 1 UP.model, UP.price
FROM (SELECT model, price FROM pc UNION SELECT model, price FROM printer UNION SELECT model, price FROM laptop) AS UP

--5. Напишете заявка, която извежда производителя на цветния принтер с
--най-ниска цена.

SELECT maker
FROM product
WHERE model = (SELECT TOP 1 model FROM printer WHERE color = 'Y' ORDER BY price ASC)

--6. Напишете заявка, която извежда производителите на тези персонални
--компютри с най-малко RAM памет, които имат най-бързи процесори.SELECT DISTINCT maker FROM productWHERE model IN (SELECT model FROM pc WHERE speed >=ALL (SELECT speed FROM pc WHERE ram <=ALL (SELECT ram FROM pc)) 									   AND model IN (SELECT model FROM pc WHERE ram <=ALL (SELECT ram FROM pc)))