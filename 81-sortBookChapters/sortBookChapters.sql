CREATE FUNCTION translate(letter VARCHAR(1)) RETURNS INT
BEGIN
	RETURN
	CASE
		WHEN letter = 'I' THEN 1
		WHEN letter = 'V' THEN 5
		WHEN letter = 'X' THEN 10
		WHEN letter = 'L' THEN 50
		WHEN letter = 'C' THEN 100
		WHEN letter = 'D' THEN 500
	    ELSE 1000
    END;
END;

CREATE FUNCTION compileRoman(symbol VARCHAR(100)) RETURNS INT
BEGIN
	SET symbol = REVERSE(symbol);
	SET @result = translate(SUBSTR(symbol, 1, 1));
	WHILE(LENGTH(symbol) > 1) DO
		SET @char1 = translate(SUBSTR(symbol, 1, 1));
		SET @char2 = translate(SUBSTR(symbol, 2, 1));
		SET @result = @result +IF(@char1 > @char2, -@char2, @char2);
		set symbol = SUBSTR(symbol,2);
	END WHILE;
	RETURN @result;
END;

CREATE PROCEDURE sortBookChapters()
	BEGIN
		SELECT chapter_name from book_chapters
		order by compileRoman(chapter_number);
	END
