--1. Създайте изглед, който извежда име на авиокомпания оператор на полета, номер на полет
--и брой пътници, потвърдили резервация за този полет. Тествайте изгледa.

CREATE VIEW flight_info (
    AIRLINE_NAME,
    AIRLINE_OPERATOR,
    FLIGHT_NUMBER,
    PASSENGER_COUNT
) AS
SELECT 
    a.NAME,
    f.AIRLINE_OPERATOR,
    f.FNUMBER,
    COUNT(b.STATUS)
FROM 
    FLIGHTS AS f
JOIN 
    AIRLINES AS a ON f.AIRLINE_OPERATOR = a.CODE
JOIN 
    BOOKINGS AS b ON f.FNUMBER = b.FLIGHT_NUMBER
WHERE 
    b.STATUS = 1
GROUP BY 
    a.NAME, f.AIRLINE_OPERATOR, f.FNUMBER;
