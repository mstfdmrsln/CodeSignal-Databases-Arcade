CREATE PROCEDURE giftPackaging()
BEGIN
	SELECT (SELECT p.package_type
            FROM packages p
            WHERE p.length >= g.length 
            AND p.width >= g.width
            AND p.height >= g.height
            ORDER BY p.length * p.width * p.height 
            LIMIT 1) AS package_type
        ,COUNT(1) AS number
    FROM gifts g
    GROUP BY package_type
    ORDER BY package_type;
END