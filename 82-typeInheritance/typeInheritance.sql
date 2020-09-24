CREATE PROCEDURE typeInheritance()
BEGIN 
	SET @first := true; 
	WHILE row_count() OR @first DO 
		SET @first := false; 
		UPDATE inheritance a 
		JOIN inheritance b ON a.base =b.derived AND a.base != "Number"
		SET a.base = b.base; 
	END WHILE; 
SELECT var_name, type AS var_type
FROM variables INNER JOIN inheritance ON 1=1 
	AND type = derived
WHERE 1=1
	AND base = 'Number'
ORDER BY var_name; 
END 
