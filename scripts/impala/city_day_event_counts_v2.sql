-- something weird going on with geonameid used here...
--
DROP TABLE IF EXISTS city_day_event_counts_v2;
CREATE EXTERNAL TABLE city_day_event_counts_v2
row format delimited
fields terminated by '|'
stored as textfile
location '/user/gdelt/city_day_event_counts_v2'
AS
  SELECT
    COUNT(*) as num_conflicts,
    SUM(NumMentions) as sum_num_mentions,
    SUM(NumArticles) as sum_num_articles,
    SUM(NumSources) as sum_num_sources,
    ActionGeo_Lat,
    ActionGeo_Long,
    SQLDATE
  FROM usa_conflict_events
  GROUP BY
    ActionGeo_Lat,
    ActionGeo_Long,
    SQLDATE;

-- for reloading into impala
-- use gdelt;
-- DROP TABLE IF EXISTS city_day_event_counts_v2;
-- CREATE EXTERNAL TABLE `city_day_event_counts_v2` (
--   `num_conflicts` bigint,
--   `sum_num_mentions` double,
--   `sum_num_articles` double,
--   `sum_num_sources` double,
--   `sqldate` bigint,
--   `state_alpha` STRING,
--   `county_name` STRING,
--   `prim_lat_dec` DOUBLE,
--   `prim_long_dec` DOUBLE
-- )
-- row format delimited
-- fields terminated by '|'
-- stored as textfile
-- location '/user/gdelt/city_day_event_counts_v2';


drop table if exists count_city_event_days;
create table count_city_event_days as select ActionGeo_Long,ActionGeo_Lat,count(*) as days_count from city_day_event_counts_v2 group by ActionGeo_Long,ActionGeo_Lat;

select * from count_city_event_days order by days_count desc limit 10;

