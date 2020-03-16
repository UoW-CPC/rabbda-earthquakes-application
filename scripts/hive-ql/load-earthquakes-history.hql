
create temporary table earthquakes-temp;
load data local inpath '/users/hh' into table earthquakes-temp;

select from raw insert earthquakes-temp




