set hive.exec.dynamic.partition = true;
set hive.exec.dynamic.partition.mode = nonstrict;
set hive.enforce.bucketing = true;
set mapreduce.map.memory.mb=4096;
set mapreduce.map.java.opts=-Xmx3686m;
set mapreduce.reduce.memory.mb=4096;
set mapreduce.reduce.java.opts=-Xmx3686m;

USE earthquakes;

-- calculate the closest city for all earthquakes in the current dataset, staging table

TRUNCATE TABLE distance_to_city_closest_stage;

INSERT OVERWRITE TABLE distance_to_city_closest_stage PARTITION(magnitude_group, year)
SELECT
  cities.eq_id as eq_id,
  cities.eq_month as eq_month,
  cities.eq_day as eq_day,
  cities.eq_y_m_d as eq_y_m_d,
  cities.eq_time as eq_time,
  cities.eq_date_time as eq_date_time,
  cities.eq_latitude as eq_latitude,
  cities.eq_longitude as eq_longitude,
  cities.eq_magnitude as eq_magnitude,
  cities.eq_place as eq_place,
  cities.eq_country as eq_country,
  cities.city_name as  city_name,
  cities.city_latitude as city_latitude,
  cities.city_longitude as city_longitude,
  cities.city_country as city_country,
  cities.city_population as city_population,
  cities.city_distance as city_distance,
  cities.magnitude_group as magnitude_group,
  cities.year as year
FROM distance_to_cities_stage cities INNER JOIN
  (
    SELECT eq_id, MIN(city_distance) as min_distance
    FROM distance_to_cities_stage
    GROUP BY eq_id
  ) closest ON cities.eq_id = closest.eq_id AND cities.city_distance = closest.min_distance;
