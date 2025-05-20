--3. Създайте тригер за таблицата Bookings, който да се задейства при вмъкване на
--резервация в таблицата и да увеличава с единица броя на пътниците, потвърдили
--резервация за таблицата Flights, както и броя на резервациите към съответната агенция.

CREATE TRIGGER reservation_insert
ON BOOKINGS AFTER INSERT
AS 
BEGIN
	UPDATE AGENCIES 
	SET num_book = num_book + (SELECT STATUS FROM inserted WHERE AGENCY = NAME);
	UPDATE FLIGHTS 
	SET num_pass = num_pass + (SELECT STATUS FROM inserted WHERE FNUMBER = FLIGHT_NUMBER)
END