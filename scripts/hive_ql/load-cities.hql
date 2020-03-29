-- create CITIES TABLE and load data

set hive.exec.dynamic.partition = true;
set hive.exec.dynamic.partition.mode = nonstrict;
set hive.enforce.bucketing = true;

USE earthquakes;
DROP TABLE if EXISTS cities;

-- step 1-2 create final table
CREATE TABLE IF NOT EXISTS cities
 (
  name string,
  name_ascii string,
  latitude double,
  longitude double,
  country string,
  iso2 string,
  iso3 string,
  admin string,
  capital string,
  population int,
  id string
  )
  CLUSTERED BY (country) SORTED BY (country) into 4 buckets STORED AS orc;

-- step 2-2 import data into final table
INSERT INTO cities SELECT * FROM cities_stage;

DROP TABLE IF EXISTS cities_stage;