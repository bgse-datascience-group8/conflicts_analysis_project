#### Results from impala!
#
create database gdelt location '/user/gdelt';
use gdelt;

create table events (  
  row_names STRING,
  GLOBALEVENTID BIGINT,
  SQLDATE BIGINT,
  MonthYear BIGINT,
  Year BIGINT,
  FractionDate FLOAT,
  Actor1Code STRING,
  Actor1Name STRING,
  Actor1CountryCode STRING,
  Actor1KnownGroupCode STRING,
  Actor1EthnicCode STRING,
  Actor1Religion1Code STRING,
  Actor1Religion2Code STRING,
  Actor1Type1Code STRING,
  Actor1Type2Code STRING,
  Actor1Type3Code STRING,
  Actor2Code STRING,
  Actor2Name STRING,
  Actor2CountryCode STRING,
  Actor2KnownGroupCode STRING,
  Actor2EthnicCode STRING,
  Actor2Religion1Code STRING,
  Actor2Religion2Code STRING,
  Actor2Type1Code STRING,
  Actor2Type2Code STRING,
  Actor2Type3Code STRING,
  IsRootEvent BIGINT,
  EventCode BIGINT,
  EventBaseCode BIGINT,
  EventRootCode BIGINT,
  QuadClass BIGINT,
  GoldsteinScale FLOAT,
  NumMentions BIGINT,
  NumSources BIGINT,
  NumArticles BIGINT,
  AvgTone FLOAT,
  Actor1Geo_Type BIGINT,
  Actor1Geo_FullName STRING,
  Actor1Geo_CountryCode STRING,
  Actor1Geo_ADM1Code STRING,
  Actor1Geo_Lat FLOAT,
  Actor1Geo_Long FLOAT,
  Actor1Geo_FeatureID STRING,
  Actor2Geo_Type BIGINT,
  Actor2Geo_FullName STRING,
  Actor2Geo_CountryCode STRING,
  Actor2Geo_ADM1Code STRING,
  Actor2Geo_Lat FLOAT,
  Actor2Geo_Long FLOAT,
  Actor2Geo_FeatureID STRING,
  ActionGeo_Type BIGINT,
  ActionGeo_FullName STRING,
  ActionGeo_CountryCode STRING,
  ActionGeo_ADM1Code STRING,
  ActionGeo_Lat FLOAT,
  ActionGeo_Long FLOAT,
  ActionGeo_FeatureID STRING,
  DATEADDED BIGINT,
  SOURCEURL STRING
)
row format delimited
fields terminated by '|'
stored as textfile;

ALTER TABLE events CHANGE GoldsteinScale GoldsteinScale STRING;
ALTER TABLE events CHANGE Actor1Geo_Lat Actor1Geo_Lat STRING;
ALTER TABLE events CHANGE Actor1Geo_Long Actor1Geo_Long STRING;
ALTER TABLE events CHANGE Actor2Geo_Lat Actor2Geo_Lat STRING;
ALTER TABLE events CHANGE Actor2Geo_Long Actor2Geo_Long STRING;
ALTER TABLE events CHANGE ActionGeo_Long ActionGeo_Long STRING;
ALTER TABLE events CHANGE ActionGeo_Lat ActionGeo_Lat STRING;

SELECT * FROM events LIMIT 10;

select count(*) from events;
-- Query: select count(*) from events
-- +-----------+
-- | count(*)  |
-- +-----------+
-- | 130753485 |
-- +-----------+
-- Returned 1 row(s) in 25.56s

select count(*) from events where Actor1Geo_CountryCode = 'US';
-- +----------+
-- | count(*) |
-- +----------+
-- | 37410376 |
-- +----------+
-- Returned 1 row(s) in 17.86s

select count(*) from events where Actor2Geo_CountryCode = 'US';
-- +----------+
-- | count(*) |
-- +----------+
-- | 28599855 |
-- +----------+

select count(*) from events where Actor2Geo_CountryCode = 'US' and Actor1Geo_CountryCode = 'US';
-- +----------+
-- | count(*) |
-- +----------+
-- | 20560207 |
-- +----------+

select count(*) from events where Actor2Geo_CountryCode = 'US' or Actor1Geo_CountryCode = 'US';
-- +----------+
-- | count(*) |
-- +----------+
-- | 45450024 |
-- +----------+

create external table usa_events_subset
row format delimited
fields terminated by '|'
stored as textfile
location '/user/gdelt/usa_events_subset'
as (
  select * from events where Actor1Geo_CountryCode = 'US' or Actor2Geo_CountryCode = 'US' and EventRootCode is not NULL
);

create external table usa_events_subset_random
row format delimited
fields terminated by '|'
stored as textfile
location '/user/gdelt/usa_events_subset_random'
as (
  select * from usa_events_subset order by RAND() limit 100000
);

insert into table usa_events_subset_random
  select * from usa_events_subset order by RAND() limit 100000;

-- 