set hive.exec.dynamic.partition = true;
set hive.exec.dynamic.partition.mode = nonstrict;
set hive.enforce.bucketing = true;



  ALTER TABLE cities set serdeproperties('field.delim'=',');





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

  ALTER TABLE cities set serdeproperties('field.delim'=',');

--create temporary table if not exists earthquakes_load
--(
--  year int,
--  month int,
--  day int,
--  y_m_d date,
--  time string,
--  date_time string,
--  latitude double,
--  longitude double,
--  depth double,
--  mag double,
--  magType string,
--  nst string,
--  gap string,
--  dmin string,
--  rms string,
--  net string,
--  id string,
--  updated string,
--  place string,
--  type string,
--  horizontalError string,
--  depthError string,
--  magError string,
--  magNst string,
--  status string,
--  locationSource string,
--  magSource string
--  )
--  set SERDEPROPERTIES ('field.delim'=',') clustered by (mag) sorted by (y_m_d) into 4 buckets;

--describe table


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