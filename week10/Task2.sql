--2. Създайте изглед, който за всяка агенция извежда името на клиента с най-много
--резервации. Тествайте изгледa.

CREATE VIEW best_customer_for_agency (
	AGENCY,
	CUSTOMER
) AS
SELECT b1.AGENCY, c.FNAME + ' ' + c.LNAME FROM BOOKINGS AS b1
JOIN CUSTOMERS AS c 
ON b1.CUSTOMER_ID = c.ID
WHERE b1.STATUS = 1
GROUP BY b1.AGENCY, b1.CUSTOMER_ID, c.FNAME, c.LNAME
HAVING COUNT(b1.CUSTOMER_ID) >= ALL(SELECT COUNT(b2.CUSTOMER_ID) FROM BOOKINGS AS b2 WHERE b2.AGENCY = b1.AGENCY AND b2.STATUS = 1)