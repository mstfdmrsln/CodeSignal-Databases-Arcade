CREATE FUNCTION P (s CHAR(9), x INT) RETURNS INT 
	RETURN IF(s RLIKE '^(...)*OOO(...)*$' OR
			s RLIKE 'O..O..O' OR
			s RLIKE 'O...O...O' OR
			s RLIKE '..O.O.O..', 
			2-x*2, 
			IF(s RLIKE '^(...)*XXX(...)*$' OR 
				s RLIKE 'X..X..X' OR
				s RLIKE 'X...X...X' OR
				s RLIKE '..X.X.X..',
				x*2, 1)
			);

CREATE PROCEDURE tictactoeTournament()
	BEGIN
		SELECT
			name,
			sum(p) points,
			count(*) played,
			sum(p=2) won,
			sum(p=1) draw,
			sum(p=0) lost
		FROM (
			SELECT
				name_naughts name,
				P(board,0) p
			FROM results

			UNION ALL

			SELECT
				name_crosses name,
				P(board,1) p
			FROM results
			) a 
		GROUP BY name
		ORDER BY sum(p) desc, played, won desc, name;
	END
