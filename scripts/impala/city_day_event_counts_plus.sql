# done in impala because difficulties locally
#
drop table if exists city_day_event_counts_plus;

create table city_day_event_counts_plus
row format delimited
fields terminated by '|'
stored as textfile
location '/user/gdelt/city_day_event_counts_plus'
as select * from city_day_event_counts_v2 as event
join geonames_cities city
on ROUND(event.ActionGeo_Lat, 3)=ROUND(city.latitude, 3) and
   ROUND(event.ActionGeo_Long, 3)=ROUND(city.longitude, 3)
where event.ActionGeo_Lat is not null and event.ActionGeo_Long is not null;

-- +-------------------------+
-- | summary                 |
-- +-------------------------+
-- | Inserted 1614074 row(s) |
-- +-------------------------+
-- Returned 1 row(s) in 57.40s

-- show create table city_day_event_counts_plus

drop table if exists count_city_event_days;
create table count_city_event_days as select geonameid,name,admin1_code,count(*) as days_count from city_day_event_counts_plus group by geonameid,name,admin1_code;

select * from count_city_event_days order by days_count desc limit 10;


drop table if exists sum_city_event_days;
create table sum_city_event_days as select geonameid,name,admin1_code,sum(num_conflicts) as total_conflicts from city_day_event_counts_plus group by geonameid,name,admin1_code;

select * from sum_city_event_days order by total_conflicts desc limit 10;
