-- Hive application database
-- Located to application HDFS path
CREATE DATABASE IF NOT EXISTS earthquakes COMMENT 'Earthquakes ETL  Pipeline' location ${path};
