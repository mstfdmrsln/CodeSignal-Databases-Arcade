CREATE PROCEDURE routeLength()
BEGIN
	select round(sum(sqrt(power(m1.x - m2.x,2) + power(m1.y - m2.y,2))), 9) total from cities as m1
    inner join cities as m2 on 1=1 and m1.id = m2.id-1;
END