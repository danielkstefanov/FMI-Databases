--II. За базата от данни PC
use pc;

--1. Напишете заявка, която извежда производител, модел и тип на продукт
--за тези производители, за които съответният продукт не се продава
--(няма го в таблиците PC, Laptop или Printer)

SELECT maker, product.model FROM product
LEFT JOIN (SELECT code, model FROM pc
	UNION 
	SELECT code, model FROM printer
	UNION 
	SELECT code, model FROM laptop) as real_products
ON	product.model = real_products.model
WHERE code IS NULL

--2. Намерете всички производители, които правят както лаптопи, така и
--принтери.

SELECT maker FROM product
WHERE type = 'Laptop'
INTERSECT
SELECT maker FROM product
WHERE type = 'Printer'

--3. Намерете размерите на тези твърди дискове, които се появяват в два
--или повече модела лаптопи.

SELECT DISTINCT hd FROM laptop l1
WHERE hd IN (SELECT hd FROM laptop l2 WHERE l1.code != l2.code)

--4. Намерете всички модели персонални компютри, които нямат регистриран
--производител.

SELECT * FROM pc
LEFT JOIN product
ON pc.model = product.model
WHERE product.maker IS NULL