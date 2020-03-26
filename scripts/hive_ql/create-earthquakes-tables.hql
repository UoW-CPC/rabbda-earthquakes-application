set hive.exec.dynamic.partition = true;
set hive.exec.dynamic.partition.mode = nonstrict;
set hive.enforce.bucketing = true;

-- Create EARTHQUAKES related tables


-- create EARTHQUAKES staging TABLE and load data

USE earthquakes;
DROP TABLE IF EXISTS earthquakes_stage;

-- step 1-* create staging table
CREATE TABLE IF NOT EXISTS earthquakes_stage
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
  mag double,
  magType string,
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
  horizontalError string,
  depthError string,
  magError string,
  magNst string,
  status string,
  locationSource string,
  magSource string
  )
ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' STORED AS TEXTFILE;

DROP TABLE IF EXISTS earthquakes;

-- step 2-* create final table
CREATE TABLE IF NOT EXISTS earthquakes
 (
  month int,
  day int,
  y_m_d date,
  time string,
  date_time string,
  latitude double,
  longitude double,
  depth double,
  mag double,
  magType string,
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
  horizontalError string,
  depthError string,
  magError string,
  magNst string,
  status string,
  locationSource string,
  magSource string
  )
  PARTITIONED BY (mag_group int, year int) CLUSTERED BY (country) SORTED BY (mag) into 4 buckets STORED AS orc;

--create table if not exists two like one;
--create external table three location '/user/test/';
--create temporary table four;
--create external table if not exists cities location '/hdfs' set serdeproperties('field.delim'=',')  clustered by latutude into 4 buckets;
--create external table if not exists seismographic-stations location '/hdfs' set serdeproperties('field.delim'=',')  clustered by (latutude) sorted by (country) into 4 buckets;
--create external table if not exists earthquakes-full location '/hdfs' set serdeproperties('field.delim'=',') partitioned by (year int, magn_group) clustered by latutude into 4 buckets;
--create view if not exists earthquakes-view;
--create external table if not exists earthquakes-to-all-cities location '/hdfs' set serdeproperties('field.delim'=',');;
--create external table if not exists earthquakes-to-closest-city location '/hdfs' set serdeproperties('field.delim'=',');;
--create external table if not exists earthquakes-to-all-stations location '/hdfs' set serdeproperties('field.delim'=',');;
--create external table if not exists earthquakes-to-closest-station location '/hdfs' set serdeproperties('field.delim'=',');;
--create external table if not exists earthquakes-results location '/hdfs' set serdeproperties('field.delim'=',') partitioned by (year int, station string);
--create external table if not exists earthquakes-per-country location '/hdfs' set serdeproperties('field.delim'=',');
--create external table if not exists earthquakes-per-year location '/hdfs' set serdeproperties('field.delim'=',');
--create external table if not exists earthquakes-per-id location '/hdfs' set serdeproperties('field.delim'=',');
--create external table if not exists earthquakes-per-location location '/hdfs' set serdeproperties('field.delim'=',');
--create external table if not exists earthquakes-magn location '/hdfs' set serdeproperties('field.delim'=',');
--create external table if not exists earthquakes-per-magn-groups location '/hdfs' set serdeproperties('field.delim'=',');