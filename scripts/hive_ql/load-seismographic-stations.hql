-- create SEISMOGRAPHIC STATIONS TABLE and load data

set hive.exec.dynamic.partition = true;
set hive.exec.dynamic.partition.mode = nonstrict;
set hive.enforce.bucketing = true;

USE earthquakes;
DROP TABLE if EXISTS seismographic_stations;

-- step 1-2 create final table
CREATE TABLE IF NOT EXISTS seismographic_stations
 (
  station_code string,
  station_name string,
  country string,
  latitude double,
  longitude double,
  datacenter string
  )
  CLUSTERED BY (country) SORTED BY (country) into 4 buckets STORED AS orc;

-- step 2-2 import data into final table
INSERT INTO seismographic_stations SELECT * FROM seismographic_stations_stage;