CASE   Fruit
       WHEN 'APPLE' THEN 'The owner is APPLE'
       WHEN 'ORANGE' THEN 'The owner is ORANGE'
       ELSE 'It is another Fruit'
END

select case x
when 1 then 'one'
when 2 then 'two'
when 0 then 'zero'
else 'out of range'
end from t1;

select case
when dayname(now()) in ('Saturday','Sunday') then 'result undefined on weekends'
when x > y then 'x greater than y'
when x = y then 'x and y are equal'
when x is null or y is null then 'one of the columns is null'
else null end
from t1;


SELECT
  date_time,
  mag,
  place,
  country,
  CASE
    WHEN mag < 2 THEN 'low'
    WHEN mag >= 2 and mag < 4 THEN 'medium'
    WHEN mag >= 4 and mag < 6 THEN 'high'
    WHEN mag >= 6 THEN 'extreme'
    ELSE NULL
  END as mag_group
  FROM earthquakes_stage;