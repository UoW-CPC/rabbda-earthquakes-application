USE earthquakes;

LOAD DATA INPATH ${path} INTO TABLE earthquakes_stage;


INSERT INTO earthtquakes PARTITION(mag_group, year)
 SELECT * FROM earthquakes_stage;



CASE   Fruit
       WHEN 'APPLE' THEN 'The owner is APPLE'
       WHEN 'ORANGE' THEN 'The owner is ORANGE'
       ELSE 'It is another Fruit'
END