select concat(if(date is not null,
	concat(' date: ', date, '; milse covered: '),
	if(driver_name is not null,
		concat(' Name: ', driver_name,
				': number of inspections: ', inspections,
				': miles driven: '),
		' Total miles driven by all drivers combined: ')
		), miles) summary
	from (select driver_name, date, sum(miles_logged) miles, 
			count(*) inspections
			from inspections
			group by driver_name,date with rollup
			) a
	order by driver_name, date;