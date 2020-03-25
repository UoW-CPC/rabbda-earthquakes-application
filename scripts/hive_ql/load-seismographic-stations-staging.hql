-- create SEISMOGRAPHIC STATIONS staging TABLE and load data

USE earthquakes;
DROP TABLE if EXISTS seismographic_stations_stage;

-- step 1-2 create staging table
CREATE TABLE  NOT EXISTS seismographic_stations_stage
 (
  station_code string,
  station_name string,
  country string,
  latitude double,
  longitude double,
  datacenter string
  )
ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' STORED AS TEXTFILE;

-- step 2-2 load data into staging table
LOAD DATA INPATH ${path} OVERWRITE INTO TABLE seismographic_stations_stage;