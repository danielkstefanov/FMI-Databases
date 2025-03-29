--III. За базата от данни PC
USE pc;

--1. Напишете заявка, която извежда всички модели лаптопи, за които се
--предлагат както разновидности с 15" екран, така и с 11" екран.

SELECT * FROM laptop
where model IN (SELECT l1.model FROM
(SELECT *
FROM
laptop
WHERE screen=15) as l1
JOIN
(SELECT *
FROM
laptop
WHERE screen=11) as l2
ON l1.model = l2.model)

--2. Да се изведат различните модели компютри, чиято цена е по-ниска
--от най-евтиния лаптоп, произвеждан от същия производител.

SELECT DISTINCT pc.model
FROM pc
	 JOIN product as p1
	 ON p1.model = pc.model
WHERE pc.price < (SELECT TOP 1 price 
				  FROM laptop JOIN product 
				  ON product.model = laptop.model
				  WHERE p1.maker = product.maker
				  ORDER BY price ASC)


--3. Един модел компютри може да се предлага в няколко разновидности с
--различна цена. Да се изведат тези модели компютри, чиято средна цена (на
--различните му разновидности) е по-ниска от най-евтиния лаптоп, произвеждан
--от същия производител.

SELECT pc.model, AVG(pc.price)
FROM pc
	 JOIN product as p1
	 ON p1.model = pc.model
GROUP BY pc.model, p1.maker
HAVING AVG(pc.price) < (SELECT TOP 1 price 
					    FROM laptop JOIN product 
					    ON product.model = laptop.model
					    WHERE p1.maker = product.maker
					    ORDER BY price ASC)

--4. Напишете заявка, която извежда за всеки компютър код на продукта,
--производител и брой компютри, които имат цена, по-голяма или равна на
--неговата.

SELECT p1.code, product.maker, COUNT(p2.code)
FROM pc as p1
JOIN product
ON p1.model = product.model
LEFT JOIN pc as p2
ON p1.price <= p2.price AND p1.code != p2.code
GROUP BY p1.code, product.maker
