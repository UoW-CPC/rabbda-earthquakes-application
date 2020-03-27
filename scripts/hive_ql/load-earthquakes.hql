set hive.exec.dynamic.partition = true;
set hive.exec.dynamic.partition.mode = nonstrict;
set hive.enforce.bucketing = true;
set mapreduce.map.memory.mb=4096;
set mapreduce.map.java.opts=-Xmx3686m;
set mapreduce.reduce.memory.mb=4096;
set mapreduce.reduce.java.opts=-Xmx3686m;


USE earthquakes;

TRUNCATE TABLE earthquakes_stage;
LOAD DATA INPATH ${path} OVERWRITE INTO TABLE earthquakes_stage;

TRUNCATE TABLE earthquakes_stage_orc;
INSERT OVERWRITE TABLE earthquakes_stage_orc PARTITION(mag_group, year)
 SELECT
  month,
  day,
  y_m_d,
  time,
  date_time,
  latitude,
  longitude,
  depth,
  mag,
  magType,
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
  horizontalError,
  depthError,
  magError,
  magNst,
  status,
  locationSource,
  magSource,
  CASE
    WHEN mag < 2 THEN 'low'
    WHEN mag >= 2 AND mag < 4 THEN 'medium'
    WHEN mag >= 4 AND mag < 6 THEN 'high'
    WHEN mag >= 6 THEN 'extreme'
    ELSE NULL
  END as mag_group,
  year
  FROM earthquakes_stage;

INSERT INTO earthquakes PARTITION(mag_group, year) SELECT * FROM earthquakes_stage_orc;

