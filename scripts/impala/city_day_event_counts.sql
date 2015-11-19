DROP TABLE IF EXISTS city_day_event_counts;
CREATE EXTERNAL TABLE city_day_event_counts
row format delimited
fields terminated by '|'
stored as textfile
location '/user/gdelt/city_day_event_counts'
AS
  SELECT 
    COUNT(*) as num_conflicts,
    SUM(NumMentions) as sum_num_mentions,
    SUM(NumArticles) as sum_num_articles,
    SUM(NumSources) as sum_num_sources,
    SQLDATE,
    FEATURE_NAME,
    FEATURE_ID,
    STATE_ALPHA,
    COUNTY_NAME,
    PRIM_LAT_DEC,
    PRIM_LONG_DEC
  FROM events_with_cities
  GROUP BY
    STATE_ALPHA,
    COUNTY_NAME,
    PRIM_LAT_DEC,
    PRIM_LONG_DEC,
    FEATURE_NAME,
    FEATURE_ID,
    SQLDATE;

-- Query: select sum(_c0) from city_day_event_counts where FEATURE_NAME is not null;
-- +------------+
-- | sum(`_c0`) |
-- +------------+
-- | 2036623    |
-- +------------+
-- Returned 1 row(s) in 0.35s
