from table select 1,2,3, ((station)*100/(sum(station) over (partion by date)) as eq_per_station;

windowing function