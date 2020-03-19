
create temporary table earthquakes-temp;
load data local inpath '/users/hh' into table earthquakes-temp;

select from raw insert earthquakes-temp

insert into earthquakes-full partition(year) select columns, year from earthquakes-temp;


