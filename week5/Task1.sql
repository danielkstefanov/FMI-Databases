--I. За базата от данни PC
USE pc;

--1. Напишете заявка, която извежда средната честота на персоналните компютри.

SELECT  CONVERT(DECIMAL(9,2),AVG(ISNULL(speed,0))) AS avg_speed 
FROM pc;

--2. Напишете заявка, която извежда средния размер на екраните на лаптопите за
--всеки производител.

SELECT product.maker,  CONVERT(DECIMAL(9,2),AVG(ISNULL(laptop.screen,0))) AS AvgScreen
FROM product JOIN laptop
ON product.model = laptop.model
GROUP BY product.maker

--3. Напишете заявка, която извежда средната честота на лаптопите с цена над 1000.

SELECT  CONVERT(DECIMAL(9,2),AVG(ISNULL(speed,0))) AS AvgSpeed
FROM laptop
WHERE price > 1000

--4. Напишете заявка, която извежда средната цена на персоналните компютри,
--произведени от производител ‘A’.

SELECT 'A' as maker, CONVERT(DECIMAL(9,2), AVG(ISNULL(price,0))) AS AvgPrice
FROM product JOIN pc
ON product.model = pc.model
WHERE product.maker = 'A'

--5. Напишете заявка, която извежда средната цена на персоналните компютри и
--лаптопите за производител ‘B’.

SELECT 'B' as maker, CONVERT(DECIMAL(9,2),AVG(ISNULL(devices.price,0))) AS AvgPrice
FROM product JOIN (SELECT * FROM (SELECT code, model, price FROM pc)as pc UNION (SELECT code, model, price FROM laptop)) as devices
ON product.model = devices.model
WHERE product.maker = 'B'

--6. Напишете заявка, която извежда средната цена на персоналните компютри
--според различните им честоти.

SELECT speed, CONVERT(DECIMAL(9,2),AVG(price)) as AvgPrice
FROM pc
GROUP BY speed

--7. Напишете заявка, която извежда производителите, които са произвели поне 3
--различни персонални компютъра (с различен код).

SELECT product.maker, COUNT(pc.code) AS number_of_pc
FROM product JOIN pc
ON product.model = pc.model
GROUP BY product.maker
HAVING COUNT(pc.code) >= 3 

--8. Напишете заявка, която извежда производителите с най-висока цена на
--персонален компютър.

SELECT TOP 1 product.maker, MAX(pc.price) AS price
FROM product JOIN pc
ON product.model = pc.model
GROUP BY product.maker

--9. Напишете заявка, която извежда средната цена на персоналните компютри за
--всяка честота по-голяма от 800.

SELECT speed, AVG(price) AS avg_speed
FROM pc
WHERE speed > 800
GROUP BY speed

--10.Напишете заявка, която извежда средния размер на диска на тези персонални
--компютри, произведени от производители, които произвеждат и принтери.
--Резултатът да се изведе за всеки отделен производител.SELECT product.maker, CONVERT(DECIMAL(9,2),AVG(pc.hd)) AS avg_hddFROM product JOIN pcON product.model = pc.modelWHERE product.maker IN (SELECT maker FROM product JOIN printer ON product.model = printer.model)GROUP BY product.maker