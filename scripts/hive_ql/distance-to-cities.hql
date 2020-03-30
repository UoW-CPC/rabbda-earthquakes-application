set hive.exec.dynamic.partition = true;
set hive.exec.dynamic.partition.mode = nonstrict;
set hive.enforce.bucketing = true;
set mapreduce.map.memory.mb=4096;
set mapreduce.map.java.opts=-Xmx3686m;
set mapreduce.reduce.memory.mb=4096;
set mapreduce.reduce.java.opts=-Xmx3686m;

USE earthquakes;

-- step 1-2 calculate distance to all cities for the current dataset, staging table

TRUNCATE TABLE distance_to_cities_stage;

INSERT OVERWRITE TABLE distance_to_cities_stage PARTITION(magnitude_group, year)
   SELECT /*+ STREAMTABLE (eq) */
  eq.id as eq_id,
  eq.month as eq_month,
  eq.day as eq_day,
  eq.y_m_d as eq_y_m_d,
  eq.time as eq_time,
  eq.date_time as eq_date_time,
  eq.latitude as eq_latitude,
  eq.longitude as eq_longitude,
  eq.magnitude as eq_magnitude,
  eq.place as eq_place,
  eq.country as eq_country,
  city.name as city_name,
  city.latitude as city_latitude,
  city.longitude as city_longitude,
  city.country as city_country,
  city.population as city_population,
  60*1.1515*(180*(acos(((sin(radians(eq.latitude))*sin(radians(city.latitude)))
              +(cos(radians(eq.latitude))*cos(radians(city.latitude))*cos(radians(eq.longitude - city.longitude))))))
          /PI()) as city_distance,
  eq.magnitude_group as magnitude_group,
  eq.year as year
  FROM cities city 
  CROSS JOIN earthquakes_stage eq;

-- step 2-2 update table distance to all cities with the current dataset
--          the table contains information for all processed datasets, final table

INSERT INTO distance_to_cities PARTITION(magnitude_group, year) SELECT * FROM distance_to_cities_stage;