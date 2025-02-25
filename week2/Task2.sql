--II.За базата от данни PC
USE PC;

--1. Напишете заявка, която извежда производителя и честотата на лаптопите с
--размер на диска поне 9 GB.

SELECT maker, speed
FROM LAPTOP AS L JOIN PRODUCT AS P
ON L.model = P.model
WHERE hd > '9'

--2. Напишете заявка, която извежда модел и цена на продуктите, произведени от
--производител с име B.

(SELECT PC.model, PC.price
FROM pc as PC JOIN product as P
ON PC.model = P.model
WHERE P.maker = 'B')
UNION
(SELECT PR.model, PR.price
FROM printer as PR JOIN product as P
ON PR.model = P.model
WHERE P.maker = 'B')
UNION
(
SELECT L.model, L.price
FROM laptop as L JOIN product as P
ON L.model = P.model
WHERE P.maker = 'B')

--3. Напишете заявка, която извежда производителите, които произвеждат лаптопи,
--но не произвеждат персонални компютри.

SELECT maker
FROM product
WHERE type = 'Laptop'
EXCEPT
SELECT maker
FROM product
WHERE type = 'PC'

--4. Напишете заявка, която извежда размерите на тези дискове, които се предлагат
--в поне два различни персонални компютъра (два компютъра с различен код).

SELECT DISTINCT PC1.hd
FROM pc AS PC1 JOIN pc AS PC2
ON PC1.hd = PC2.hd
WHERE PC1.code != PC2.code

--5. Напишете заявка, която извежда двойките модели на персонални компютри,
--които имат еднаква честота и памет. Двойките трябва да се показват само по
--веднъж, например само (i, j), но не и (j, i).

SELECT PC1.model, PC2.model
FROM pc AS PC1 JOIN pc AS PC2
ON PC1.speed = PC2.speed AND PC1.ram = PC2.ram AND PC1.code != PC2.code
WHERE PC1.model < PC2.model

--6. Напишете заявка, която извежда производителите на поне два различни
--персонални компютъра с честота поне 400.

SELECT DISTINCT PC1PRODUCT.maker
FROM dbo.pc AS PC1, dbo.pc AS PC2, dbo.product AS PC1PRODUCT, dbo.product AS PC2PRODUCT
WHERE PC1.code!= PC2.code 
	AND PC1.model = PC1PRODUCT.model 
	AND PC2.model = PC2PRODUCT.model 
	AND PC1PRODUCT.maker = PC2PRODUCT.maker 
	AND PC1.speed>=400 
	AND PC2.speed>=400
