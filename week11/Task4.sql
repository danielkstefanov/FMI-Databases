--4. Създайте тригер за таблицата Bookings, който да се задейства при изтриване на
--резервация в таблицата и да намалява с единица броя на пътниците, потвърдили
--резервация за таблицата Flights, както и броя на резервациите към съответната агенция.

CREATE TRIGGER reservation_delete
ON BOOKINGS AFTER DELETE
AS 
BEGIN
	UPDATE AGENCIES 
	SET num_book = num_book - (SELECT STATUS FROM deleted WHERE AGENCY = NAME);
	UPDATE FLIGHTS 
	SET num_pass = num_pass - (SELECT STATUS FROM deleted WHERE FNUMBER = FLIGHT_NUMBER)
END