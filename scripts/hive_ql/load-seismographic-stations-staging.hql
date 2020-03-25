-- create SEISMOGRAPHIC STATIONS staging TABLE and load data

USE earthquakes;
DROP TABLE if EXISTS seismographic_stations_stage;

-- step 1-2 create staging table
CREATE TABLE IF NOT EXISTS seismographic_stations_stage
(
  city string,
  city_ascii string,
  latitude double,
  longitude double,
  country string,
  iso2 string,
  iso3 string,
  admin_name string,
  capital string,
  population int,
  id string
  )
ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' STORED AS TEXTFILE;

-- step 2-2 load data into staging table
LOAD DATA INPATH ${path} OVERWRITE INTO TABLE seismographic_stations_stage;