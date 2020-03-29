set hive.exec.dynamic.partition = true;
set hive.exec.dynamic.partition.mode = nonstrict;
set hive.enforce.bucketing = true;
set mapreduce.map.memory.mb=4096;
set mapreduce.map.java.opts=-Xmx3686m;
set mapreduce.reduce.memory.mb=4096;
set mapreduce.reduce.java.opts=-Xmx3686m;

USE earthquakes;

-- calculate the closest station for all earthquakes in the current dataset, staging table

TRUNCATE TABLE distance_to_station_closest_stage;

INSERT OVERWRITE TABLE distance_to_station_closest_stage PARTITION(magnitude_group, year)
SELECT
  stations.eq_id as eq_id,
  stations.eq_month as eq_month,
  stations.eq_day as eq_day,
  stations.eq_y_m_d as eq_y_m_d,
  stations.eq_time as eq_time,
  stations.eq_date_time as eq_date_time,
  stations.eq_latitude as eq_latitude,
  stations.eq_longitude as eq_longitude,
  stations.eq_magnitude as eq_magnitude,
  stations.eq_place as eq_place,
  stations.eq_country as eq_country,
  stations.station_code as station_code,
  stations.station_name as station_name,
  stations.station_country as station_country,
  stations.station_latitude as station_latitude,
  stations.station_longitude as station_longitude,
  stations.station_datacenter as station_datacenter,
  stations.station_distance as station_distance,
  stations.magnitude_group as magnitude_group,
  stations.year as year
FROM distance_to_stations_stage stations INNER JOIN
  (
    SELECT eq_id, MIN(station_distance) as min_distance
    FROM distance_to_stations_stage
    GROUP BY eq_id
  ) closest ON stations.eq_id = closest.eq_id AND stations.station_distance = closest.min_distance;
