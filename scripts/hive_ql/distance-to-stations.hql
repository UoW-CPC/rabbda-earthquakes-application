set hive.exec.dynamic.partition = true;
set hive.exec.dynamic.partition.mode = nonstrict;
set hive.enforce.bucketing = true;
set mapreduce.map.memory.mb=4096;
set mapreduce.map.java.opts=-Xmx3686m;
set mapreduce.reduce.memory.mb=4096;
set mapreduce.reduce.java.opts=-Xmx3686m;

USE earthquakes;

TRUNCATE TABLE distance_to_stations_stage;

INSERT OVERWRITE TABLE distance_to_stations_stage PARTITION(magnitude_group, year)
 SELECT
  eq.id as eq_id,
  eq.month as eq_month,
  eq.day as eq_day,
  eq.y_m_d as eq_y_m_d,
  eq.time as eq_time,
  eq.date_time as eq_date_time,
  eq.latitude as eq_latitude,
  eq.longitude as eq_longitude,
  eq.mag as eq_magnitude,
  eq.place as eq_place,
  eq.country as eq_country,
  station.station_code as station_code,
  station.station_name as station_name,
  station.country as station_country,
  station.latitude as station_latitude,
  station.longitude as station_longitude,
  station.datacenter as station_datacenter,
  eq.mag_group as eq_magnitude_group,
  eq.year as eq_year
  FROM earthquakes_stage eq
  CROSS JOIN seismographic_stations station;

INSERT INTO earthquakes PARTITION(magnitude_group, year) SELECT * FROM earthquakes_stage_orc;



