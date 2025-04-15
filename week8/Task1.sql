
CREATE DATABASE TECHSHOP;

USE TECHSHOP

--Задача 1

--а) Дефинирайте следните релации:

---Product (maker, model, type), където:
--- модел е низ от точно 4 символа,
--- производител е низ от точно 1 символ,
--- тип е низ до 7 символа;

CREATE TABLE Product (
	model CHAR(4),
	producer CHAR(1),
	type VARCHAR(7),
)

---Printer (code, model, price), където:
--- код е цяло число,
--- модел е низ от точно 4 символа,
--- цена с точност до два знака след десетичната запетая;

CREATE TABLE Printer (
	code INTEGER,
	model CHAR(4),
	price DECIMAL(8,2)
)

--б) Добавете кортежи с примерни данни към новосъздадените релации.

INSERT INTO Product VALUES 
	('KJOF', 'R', 'fast'),
	('PGRG', 'P', 'slow'),
	('LOKM', 'F', 'cool')

INSERT INTO Printer VALUES 
	(244, 'KJOF', 123.45),
	(544, 'PGRG', 543.23),
	(122, 'LOKM', 99.99)


--в) Добавете към релацията Printer атрибути:

--- type - низ до 6 символа (забележка: type може да приема
--- стойност 'laser', 'matrix' или 'jet'),
--- color - низ от точно 1 символ, стойност по подразбиране 'n'
--(забележка: color може да приема стойност 'y' или 'n').

ALTER TABLE Printer ADD type VARCHAR(6), color CHAR(1);

--г) Напишете заявка, която премахва атрибута price от релацията Printer.

ALTER TABLE Printer DROP COLUMN price;

--д) Изтрийте релациите, които сте създали в Задача 1.

DROP DATABASE TECHSHOP