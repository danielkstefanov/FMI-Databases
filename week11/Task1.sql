--1. Добавете нова колона num_pass към таблицата Flights, която ще съдържа броя на
--   пътниците, потвърдили резервация за съответния полет.

ALTER TABLE FLIGHTS
ADD num_pass INT DEFAULT 0;

ALTER TABLE FLIGHTS
ADD CONSTRAINT chk_num_pass CHECK (num_pass >= 0);

ALTER TABLE FLIGHTS
DROP COLUMN num_pass

UPDATE FLIGHTS
SET num_pass = (SELECT COUNT(*) FROM BOOKINGS WHERE FLIGHT_NUMBER = FLIGHTS.FNUMBER AND STATUS = 1)