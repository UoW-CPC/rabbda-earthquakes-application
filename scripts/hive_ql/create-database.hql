-- Hive application database
-- Located to application HDFS path
CREATE DATABASE if not EXISTS earthquakes COMMENT 'Earthquakes ETL  Pipeline' location ${path};
