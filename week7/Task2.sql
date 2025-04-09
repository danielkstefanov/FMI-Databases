--Извършете следните модификации в базата от данни PC:
USE pc;

--4. Използвайте две INSERT заявки. Съхранете в базата данни факта, че персонален компютър
--модел 1100 е направен от производителя C, има процесор 2400 MHz, RAM 2048 MB, твърд диск
--500 GB, 52x оптично дисково устройство и струва $299. Нека новият компютър има код 12.
--Забележка: модел и CD са от тип низ.

INSERT INTO product (maker, model, type)
VALUES ('C', 1100, 'pc')

INSERT INTO pc (code, model, speed, ram, hd, cd, price)
VALUES (12,1100, 2400, 2048, 500, '52x',299)

--5. Да се изтрие наличната информация в таблицата PC за компютри модел 1100.

DELETE FROM pc
WHERE model = 1100

--6. Да се изтрият от таблицата Laptop всички лаптопи, направени от производител, който не
--произвежда принтери.

DELETE FROM laptop
WHERE model IN (SELECT model FROM product WHERE type='laptop' 
				EXCEPT
				SELECT model FROM product WHERE type='printer') 

--7. Производител А купува производител B. На всички продукти на В променете производителя да
--бъде А.

UPDATE product
SET maker='A'
WHERE maker='B'

--8. Да се намали наполовина цената на всеки компютър
--   и да се добавят по 20 GB към всеки твърд диск.
UPDATE pcSET price=price/2, 	hd=hd+20;--9. За всеки лаптоп от производител B добавете по един инч към диагонала на екрана.UPDATE laptopSET screen=screen+1WHERE model IN (SELECT model FROM product WHERE type='laptop' AND maker='B')