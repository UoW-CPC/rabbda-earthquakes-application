
create table if not exists two like one;


create external table three location '/user/test/';

create temporary table four;




create external table if not exists cities location '/hdfs' set serdeproperties('field.delim'=',');
create external table if not exists seismographic-stations location '/hdfs' set serdeproperties('field.delim'=',');;
create external table if not exists earthquakes-full location '/hdfs' set serdeproperties('field.delim'=',');;
create view if not exists earthquakes-view;
create external table if not exists earthquakes-to-all-cities location '/hdfs' set serdeproperties('field.delim'=',');;
create external table if not exists earthquakes-to-closest-city location '/hdfs' set serdeproperties('field.delim'=',');;
create external table if not exists earthquakes-to-all-stations location '/hdfs' set serdeproperties('field.delim'=',');;
create external table if not exists earthquakes-to-closest-station location '/hdfs' set serdeproperties('field.delim'=',');;
create external table if not exists earthquakes-results location '/hdfs' set serdeproperties('field.delim'=',');

create external table if not exists earthquakes-per-country location '/hdfs' set serdeproperties('field.delim'=',');
create external table if not exists earthquakes-per-year location '/hdfs' set serdeproperties('field.delim'=',');
create external table if not exists earthquakes-per-id location '/hdfs' set serdeproperties('field.delim'=',');
create external table if not exists earthquakes-per-location location '/hdfs' set serdeproperties('field.delim'=',');
create external table if not exists earthquakes-magn location '/hdfs' set serdeproperties('field.delim'=',');
create external table if not exists earthquakes-per-magn-groups location '/hdfs' set serdeproperties('field.delim'=',');