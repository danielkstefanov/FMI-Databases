--2. Добавете нова колона num_book към таблицата Agencies, която ще съдържа броя на
--   резервациите към съответната агенция.

ALTER TABLE AGENCIES
ADD num_book INT DEFAULT 0;

ALTER TABLE AGENCIES
ADD CONSTRAINT chk_num_book CHECK (num_book >= 0);

UPDATE AGENCIES
SET num_book= (SELECT COUNT(*) FROM BOOKINGS WHERE AGENCY= AGENCIES.NAME AND STATUS = 1)