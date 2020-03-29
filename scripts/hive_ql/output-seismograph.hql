set hive.exec.dynamic.partition = true;
set hive.exec.dynamic.partition.mode = nonstrict;
set hive.enforce.bucketing = true;
set mapreduce.map.memory.mb=4096;
set mapreduce.map.java.opts=-Xmx3686m;
set mapreduce.reduce.memory.mb=4096;
set mapreduce.reduce.java.opts=-Xmx3686m;

USE earthquakes;

TRUNCATE TABLE output_stage;

INSERT OVERWRITE TABLE output_stage PARTITION(magnitude_group, year)
SELECT
  city.eq_id as eq_id,
  city.eq_month as eq_month,
  city.eq_day as eq_day,
  city.eq_y_m_d as eq_y_m_d,
  city.eq_time as eq_time,
  city.eq_date_time as eq_date_time,
  city.eq_latitude as eq_latitude,
  city.eq_longitude as eq_longitude,
  city.eq_magnitude as eq_magnitude,
  city.eq_place as eq_place,
  city.eq_country as eq_country,
  city.city_name as  city_name,
  city.city_latitude as city_latitude,
  city.city_longitude as city_longitude,
  city.city_country as city_country,
  city.city_population as city_population,
  city.city_distance as city_distance,
  station.station_code as station_code,
  station.station_name as station_name,
  station.station_country as station_country,
  station.station_latitude as station_latitude,
  station.station_longitude as station_longitude,
  station.station_datacenter as station_datacenter,
  station.station_distance as station_distance,
  station.magnitude_group as magnitude_group,
  station.year as year
FROM distance_to_station_closest_stage station JOIN distance_to_city_closest_stage city on (station.eq_id = city.eq_id);

INSERT INTO output_seismograph PARTITION(magnitude_group, year)
SELECT
  eq_id,
  eq_month,
  eq_day,
  eq_y_m_d,
  eq_time,
  eq_date_time,
  eq_latitude,
  eq_longitude,
  eq_magnitude,
  eq_place,
  eq_country,
  city_name,
  city_latitude,
  city_longitude,
  city_country,
  city_population,
  city_distance,
  station_code,
  station_name,
  station_country,
  station_latitude,
  station_longitude,
  station_datacenter,
  station_distance,
  station_seismograph,
  magnitude_group,
  year
FROM output_stage join
(SELECT transform(eq_y_m_d,station_code,eq_id) using 'python seismograph.py' as station_seismograph
  FROM output_stage) station_seismograph;


