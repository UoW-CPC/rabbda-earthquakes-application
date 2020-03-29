set hive.exec.dynamic.partition = true;
set hive.exec.dynamic.partition.mode = nonstrict;
set hive.enforce.bucketing = true;

-- Create EARTHQUAKES related tables

USE earthquakes;

-- step 1-10 create EARTHQUAKES staging TABLE

DROP TABLE IF EXISTS earthquakes_stage_textfile;

CREATE TABLE IF NOT EXISTS earthquakes_stage_textfile
(
  year int,
  month int,
  day int,
  y_m_d date,
  time string,
  date_time string,
  latitude double,
  longitude double,
  depth double,
  magnitude double,
  magnitude_type string,
  nst string,
  gap string,
  dmin string,
  rms string,
  net string,
  id string,
  updated string,
  place string,
  country string,
  type string,
  horizontal_error string,
  depth_error string,
  magnitude_error string,
  magnitude_nst string,
  status string,
  location_source string,
  magnitude_source string
  )
ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' STORED AS TEXTFILE TBLPROPERTIES('serialization.null.format'='');

-- step 2-10 create EARTHQUAKES staging TABLE as ORC

DROP TABLE IF EXISTS earthquakes_stage;

CREATE TABLE IF NOT EXISTS earthquakes_stage
 (
  month int,
  day int,
  y_m_d string,
  time string,
  date_time string,
  latitude double,
  longitude double,
  depth double,
  magnitude double,
  magnitude_type string,
  nst string,
  gap string,
  dmin string,
  rms string,
  net string,
  id string,
  updated string,
  place string,
  country string,
  type string,
  horizontal_error string,
  depth_error string,
  magnitude_error string,
  magnitude_nst string,
  status string,
  location_source string,
  magnitude_source string
  )
  PARTITIONED BY (magnitude_group string, year int) CLUSTERED BY (country) SORTED BY (y_m_d) into 4 buckets STORED AS orc TBLPROPERTIES('serialization.null.format'='');

-- step 3-10 create EARTHQUAKES final TABLE as ORC

DROP TABLE IF EXISTS earthquakes;

CREATE TABLE IF NOT EXISTS earthquakes
 (
  month int,
  day int,
  y_m_d string,
  time string,
  date_time string,
  latitude double,
  longitude double,
  depth double,
  magnitude double,
  magnitude_type string,
  nst string,
  gap string,
  dmin string,
  rms string,
  net string,
  id string,
  updated string,
  place string,
  country string,
  type string,
  horizontal_error string,
  depth_error string,
  magnitude_error string,
  magnitude_nst string,
  status string,
  location_source string,
  magnitude_source string
  )
  PARTITIONED BY (magnitude_group string, year int) CLUSTERED BY (country) SORTED BY (y_m_d) into 4 buckets STORED AS orc TBLPROPERTIES('serialization.null.format'='');

-- step 4-10 create DISTANCE TO NEAR CITIES staging TABLE as ORC

DROP TABLE IF EXISTS distance_to_cities_stage;

CREATE TABLE IF NOT EXISTS distance_to_cities_stage
(
  eq_id string,
  eq_month int,
  eq_day int,
  eq_y_m_d string,
  eq_time string,
  eq_date_time string,
  eq_latitude double,
  eq_longitude double,
  eq_magnitude double,
  eq_place string,
  eq_country string,
  city_name string,
  city_latitude double,
  city_longitude double,
  city_country string,
  city_population int,
  city_distance double
  )
PARTITIONED BY (magnitude_group string, year int) CLUSTERED BY (eq_country) SORTED BY (eq_y_m_d) into 4 buckets STORED AS orc TBLPROPERTIES('serialization.null.format'='');

-- step 5-10 create DISTANCE TO NEAR CITIES final TABLE as ORC

DROP TABLE IF EXISTS distance_to_cities;

CREATE TABLE IF NOT EXISTS distance_to_cities
(
  eq_id string,
  eq_month int,
  eq_day int,
  eq_y_m_d string,
  eq_time string,
  eq_date_time string,
  eq_latitude double,
  eq_longitude double,
  eq_magnitude double,
  eq_place string,
  eq_country string,
  city_name string,
  city_latitude double,
  city_longitude double,
  city_country string,
  city_population int,
  city_distance double
  )
PARTITIONED BY (magnitude_group string, year int) CLUSTERED BY (eq_country) SORTED BY (eq_y_m_d) into 4 buckets STORED AS orc TBLPROPERTIES('serialization.null.format'='');

-- step 6-10 create DISTANCE TO CLOSEST CITY staging TABLE as ORC

DROP TABLE IF EXISTS distance_to_city_closest_stage;

CREATE TABLE IF NOT EXISTS distance_to_city_closest_stage
(
  eq_id string,
  eq_month int,
  eq_day int,
  eq_y_m_d string,
  eq_time string,
  eq_date_time string,
  eq_latitude double,
  eq_longitude double,
  eq_magnitude double,
  eq_place string,
  eq_country string,
  city_name string,
  city_latitude double,
  city_longitude double,
  city_country string,
  city_population int,
  city_distance double
  )
PARTITIONED BY (magnitude_group string, year int) CLUSTERED BY (eq_country) SORTED BY (eq_y_m_d) into 4 buckets STORED AS orc TBLPROPERTIES('serialization.null.format'='');

-- step 7-10 create DISTANCE TO NEAR SEISMOGRAPHIC STATIONS staging TABLE as ORC

DROP TABLE IF EXISTS distance_to_stations_stage;

CREATE TABLE IF NOT EXISTS distance_to_stations_stage
(
  eq_id string,
  eq_month int,
  eq_day int,
  eq_y_m_d string,
  eq_time string,
  eq_date_time string,
  eq_latitude double,
  eq_longitude double,
  eq_magnitude double,
  eq_place string,
  eq_country string,
  station_code string,
  station_name string,
  station_country string,
  station_latitude double,
  station_longitude double,
  station_datacenter string,
  station_distance double,
  station_seismograph string
  )
PARTITIONED BY (magnitude_group string, year int) CLUSTERED BY (eq_country) SORTED BY (eq_y_m_d) into 4 buckets STORED AS orc TBLPROPERTIES('serialization.null.format'='');

-- step 8-10 create DISTANCE TO NEAR SEISMOGRAPHIC STATIONS final TABLE as ORC

DROP TABLE IF EXISTS distance_to_stations;

CREATE TABLE IF NOT EXISTS distance_to_stations
(
  eq_id string,
  eq_month int,
  eq_day int,
  eq_y_m_d string,
  eq_time string,
  eq_date_time string,
  eq_latitude double,
  eq_longitude double,
  eq_magnitude double,
  eq_place string,
  eq_country string,
  station_code string,
  station_name string,
  station_country string,
  station_latitude double,
  station_longitude double,
  station_datacenter string,
  station_distance double,
  station_seismograph string
  )
PARTITIONED BY (magnitude_group string, year int) CLUSTERED BY (eq_country) SORTED BY (eq_y_m_d) into 4 buckets STORED AS orc TBLPROPERTIES('serialization.null.format'='');

-- step 9-10 create DISTANCE TO CLOSEST SEISMOGRAPHIC STATIONS staging TABLE as ORC

DROP TABLE IF EXISTS distance_to_station_closest_stage;

CREATE TABLE IF NOT EXISTS distance_to_station_closest_stage
(
  eq_id string,
  eq_month int,
  eq_day int,
  eq_y_m_d string,
  eq_time string,
  eq_date_time string,
  eq_latitude double,
  eq_longitude double,
  eq_magnitude double,
  eq_place string,
  eq_country string,
  station_code string,
  station_name string,
  station_country string,
  station_latitude double,
  station_longitude double,
  station_datacenter string,
  station_distance double,
  station_seismograph string
  )
PARTITIONED BY (magnitude_group string, year int) CLUSTERED BY (eq_country) SORTED BY (eq_y_m_d) into 4 buckets STORED AS orc TBLPROPERTIES('serialization.null.format'='');

-- step 10-10 create OUTPUT TABLE as ORC

DROP TABLE IF EXISTS output;

CREATE TABLE IF NOT EXISTS output
(
  eq_id string,
  eq_month int,
  eq_day int,
  eq_y_m_d string,
  eq_time string,
  eq_date_time string,
  eq_latitude double,
  eq_longitude double,
  eq_magnitude double,
  eq_place string,
  eq_country string,
  city_name string,
  city_latitude double,
  city_longitude double,
  city_country string,
  city_population int,
  city_distance double,
  station_code string,
  station_name string,
  station_country string,
  station_latitude double,
  station_longitude double,
  station_datacenter string,
  station_distance double,
  station_seismograph string
  )
PARTITIONED BY (magnitude_group string, year int) CLUSTERED BY (eq_country) SORTED BY (eq_y_m_d) into 4 buckets STORED AS orc TBLPROPERTIES('serialization.null.format'='');

