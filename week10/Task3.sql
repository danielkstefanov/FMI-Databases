--3. Създайте изглед за таблицата Agencies, който извежда всички данни за агенциите от град
--София. Дефинирайте изгледa с CHECK OPTION. Тествайте изгледa.

CREATE VIEW sofia_agencies AS 
SELECT * FROM AGENCIES
WHERE CITY = 'Sofia'
WITH CHECK OPTION