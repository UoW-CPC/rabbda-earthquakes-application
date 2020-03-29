

CASE   Fruit
       WHEN 'APPLE' THEN 'The owner is APPLE'
       WHEN 'ORANGE' THEN 'The owner is ORANGE'
       ELSE 'It is another Fruit'
END

select case x
when 1 then 'one'
when 2 then 'two'
when 0 then 'zero'
else 'out of range'
end from t1;

select case
when dayname(now()) in ('Saturday','Sunday') then 'result undefined on weekends'
when x > y then 'x greater than y'
when x = y then 'x and y are equal'
when x is null or y is null then 'one of the columns is null'
else null end
from t1;


SELECT
  date_time,
  mag,
  place,
  country,
  CASE
    WHEN mag < 2 THEN 'low'
    WHEN mag >= 2 and mag < 4 THEN 'medium'
    WHEN mag >= 4 and mag < 6 THEN 'high'
    WHEN mag >= 6 THEN 'extreme'
    ELSE NULL
  END as mag_group
  FROM earthquakes_stage;




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



add file seismograph.py;
insert into
SELECT transform(eq_y_m_d,station_code,eq_id) using 'python seismograph.py' as station_seismograph from distance_to_stations_stage;

  SELECT
  transform(eq_y_m_d,station_code,eq_id) using 'python seismograph.py' as station_seismograph
  FROM output_stage;