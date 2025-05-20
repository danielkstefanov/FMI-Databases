--5. Създайте тригер за таблицата Bookings, който да се задейства при обновяване на
--резервация в таблицата и да увеличава или намалява с единица броя на пътниците,
--потвърдили резервация за таблицата Flights при промяна на статуса на резервацията.

CREATE TRIGGER reservation_update
ON BOOKINGS AFTER UPDATE
AS
BEGIN
UPDATE FLIGHTS
SET num_pass=(num_pass- (SELECT COUNT(*) FROM deleted WHERE status=1 AND
FNUMBER IN (SELECT flight_number FROM inserted WHERE status=0)));
UPDATE FLIGHTS
SET num_pass=(num_pass- (SELECT COUNT(*) FROM deleted WHERE status=0 AND
FNUMBER IN (SELECT flight_number FROM inserted WHERE status=1)));
END