-- Hive application database
-- Located to application HDFS path
create database if not exists earthquakes comment 'Earthquakes ETL  Pipeline' location ${path};
