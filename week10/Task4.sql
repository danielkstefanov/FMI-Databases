--4. Създайте изглед за таблицата Agencies, който извежда всички данни за агенциите, такива
--че телефонните номера на тези агенции да имат стойност NULL. Дефинирайте изгледa с
--CHECK OPTION. Тествайте изгледa.CREATE VIEW no_phone_agencies AS 
SELECT * FROM AGENCIES
WHERE PHONE IS NULL
WITH CHECK OPTION