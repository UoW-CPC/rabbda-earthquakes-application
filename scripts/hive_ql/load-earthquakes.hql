set hive.exec.dynamic.partition = true;
set hive.exec.dynamic.partition.mode = nonstrict;
set hive.enforce.bucketing = true;
set mapreduce.map.memory.mb=4096;
set mapreduce.map.java.opts=-Xmx3686m;
set mapreduce.reduce.memory.mb=4096;
set mapreduce.reduce.java.opts=-Xmx3686m;


USE earthquakes;

TRUNCATE TABLE earthquakes_stage_textfile;
LOAD DATA INPATH ${path} OVERWRITE INTO TABLE earthquakes_stage_textfile;

TRUNCATE TABLE earthquakes_stage;
INSERT OVERWRITE TABLE earthquakes_stage PARTITION(magnitude_group, year)
 SELECT
  month,
  day,
  y_m_d,
  time,
  date_time,
  latitude,
  longitude,
  depth,
  magnitude,
  magnitude_type,
  nst,
  gap,
  dmin,
  rms,
  net,
  id,
  updated,
  place,
  country,
  type,
  horizontal_error,
  depth_error,
  magnitude_error,
  magnitude_nst,
  status,
  location_source,
  magnitude_source,
  CASE
    WHEN magnitude < 2 THEN 'low'
    WHEN magnitude >= 2 AND magnitude < 4 THEN 'medium'
    WHEN magnitude >= 4 AND magnitude < 6 THEN 'high'
    WHEN magnitude >= 6 THEN 'extreme'
    ELSE NULL
  END as magnitude_group,
  year
  FROM earthquakes_stage_textfile;

INSERT INTO earthquakes PARTITION(magnitude_group, year) SELECT * FROM earthquakes_stage;

