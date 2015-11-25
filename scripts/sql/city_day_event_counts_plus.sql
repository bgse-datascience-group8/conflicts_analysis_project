# done in impala because difficulties locally
#
drop table if exists city_day_event_counts_plus;

create table city_day_event_counts_plus
row format delimited
fields terminated by '|'
stored as textfile
location '/user/gdelt/city_day_event_counts_plus'
as select * from city_day_event_counts as event_count
join geonames_cities city
on ROUND(event_count.prim_lat_dec, 3)=ROUND(city.latitude, 3) and
   ROUND(event_count.prim_long_dec, 3)=ROUND(city.longitude, 3);

-- show create table city_day_event_counts_plus

drop table if exists count_city_event_days;
create table count_city_event_days as select feature_id,count(*) as days_count from city_day_event_counts_plus group by feature_id;

select * from count_city_event_days order by days_count desc limit 10;
