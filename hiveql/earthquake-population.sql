use earthquakes;

SELECT id,time,day,magnitude,country,city,population,city_distance
FROM earthquakes_distance_to_all_cities
WHERE id='us2000j1d4' AND population is NOT NULL
ORDER BY city_distance limit 30;