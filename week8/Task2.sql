--Задача 2

CREATE DATABASE Facebook
USE Facebook

--а) Нека създадем мини вариант на Facebook. Искаме да имаме следните
--релации (може да предложите и друг вариант):

--- Users: уникален номер (id), email, парола, дата на регистрация.

CREATE TABLE Users (
	id INT IDENTITY(1,1),
	email VARCHAR(64),
	password VARCHAR(64),
	registrationDate DATE
)

--- Friends: двойки от номера на потребители, напр. ако 12 е приятел на 21, 25 и
--40, ще има кортежи (12,21), (12,25), (12,40).

CREATE TABLE Friends (
	firstUser INT NOT NULL,
	secondUser INT NOT NULL
)

--- Walls: номер на потребител, номер на потребител написал съобщението,
--текст на съобщението, дата.

CREATE TABLE Walls (
	userId INT NOT NULL,
	text VARCHAR(256),
	date DATETIME
)

--- Groups: уникален номер, име, описание (по подразбиране - празен низ).

CREATE TABLE Groups (
	id INT IDENTITY(1,1),
	name VARCHAR(64),
	description VARCHAR(512) DEFAULT ''
)

--- GroupMembers: двойки от вида номер на група - номер на потребител.

CREATE TABLE GroupMembers (
	userId INT NOT NULL,
	groupId INT NOT NULL
)

--б) Добавете кортежи с примерни данни към новосъздадените релации.

INSERT INTO Users VALUES
('vasiprasi@abv.bg','password123', '2025-04-14'),
('danibanani@abv.bg','daniPass123', '2025-03-14')

INSERT INTO Friends VALUES 
(1,2)

INSERT INTO Groups VALUES 
('Corgi lovers', 'Group for all the lovers of the corgi breed!')

INSERT INTO GroupMembers VALUES
(1,1),
(2,1)