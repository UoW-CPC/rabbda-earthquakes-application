-- create CITIES staging TABLE and load data

USE earthquakes;

-- step 1-2 create staging table
CREATE TABLE IF NOT EXISTS cities_stage
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
LOAD DATA INPATH ${path} OVERWRITE INTO TABLE cities_stage;