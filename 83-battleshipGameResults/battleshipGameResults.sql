CREATE PROCEDURE battleshipGameResults()
BEGIN
	SELECT
        size, sum(shots = 0) AS undamaged,
        sum(shots between 1 and size-1) as partly_damaged,
        sum(shots = size) AS sunk
    FROM (
        SELECT
        bottom_right_x - upper_left_x + bottom_right_y - upper_left_y + 1 AS size,
        sum((target_x BETWEEN upper_left_x and bottom_right_x)
            and (target_y BETWEEN upper_left_y and bottom_right_y)) as shots
        FROM 
        locations_of_ships,
        opponents_shots GROUP BY locations_of_ships.id) as ships 
    GROUP BY size
    ORDER BY size;
END