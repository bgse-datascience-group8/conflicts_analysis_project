delete from city_day_event_counts_plus where name like 'Moscow%';

-- MySQL [gdelt]> select sum(num_conflicts) from city_day_event_counts_plus;
-- +--------------------+
-- | sum(num_conflicts) |
-- +--------------------+
-- |            1507041 |
-- +--------------------+
-- 1 row in set (0.08 sec)

drop table if exists count_city_event_days;

create table count_city_event_days as select geonameid,name,admin1_code,count(*) as days_count
  from city_day_event_counts_plus
  group by geonameid,name,admin1_code;

delete from count_city_event_days where admin1_code = 'HI';
delete from count_city_event_days where admin1_code = 'AK';

drop table if exists top_100_cities;
create table top_100_cities as select * from count_city_event_days order by days_count desc limit 100;

# TODO: Limit columns
drop table if exists top_cities;
create table top_cities as
  select c.num_conflicts,
    c.sum_num_mentions,
    c.sum_num_articles,
    c.sum_num_sources,
    c.actiongeo_lat,
    c.actiongeo_long,
    c.sqldate,
    c.geonameid,
    c.name,
    c.asciiname,
    c.latitude,
    c.longitude,
    c.admin1_code,
    c.population,
    c.timezone
  from top_100_cities top
  left join city_day_event_counts_plus c
  on top.geonameid = c.geonameid;
