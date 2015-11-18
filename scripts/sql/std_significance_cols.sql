-- cloudera instance

create database gdelt location '/user/gdelt';
use gdelt;

create table usa_conflict_events (  
  row_names STRING,
  GLOBALEVENTID BIGINT,
  SQLDATE BIGINT,
  MonthYear BIGINT,
  Year BIGINT,
  FractionDate STRING,
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
  GoldsteinScale STRING,
  NumMentions BIGINT,
  NumSources BIGINT,
  NumArticles BIGINT,
  AvgTone STRING,
  Actor1Geo_Type BIGINT,
  Actor1Geo_FullName STRING,
  Actor1Geo_CountryCode STRING,
  Actor1Geo_ADM1Code STRING,
  Actor1Geo_Lat STRING,
  Actor1Geo_Long STRING,
  Actor1Geo_FeatureID STRING,
  Actor2Geo_Type BIGINT,
  Actor2Geo_FullName STRING,
  Actor2Geo_CountryCode STRING,
  Actor2Geo_ADM1Code STRING,
  Actor2Geo_Lat STRING,
  Actor2Geo_Long STRING,
  Actor2Geo_FeatureID STRING,
  ActionGeo_Type BIGINT,
  ActionGeo_FullName STRING,
  ActionGeo_CountryCode STRING,
  ActionGeo_ADM1Code STRING,
  ActionGeo_Lat STRING,
  ActionGeo_Long STRING,
  ActionGeo_FeatureID STRING,
  DATEADDED BIGINT,
  SOURCEURL STRING
)
row format delimited
fields terminated by '|'
stored as textfile;

DROP TABLE IF EXISTS significance_cols;

CREATE TABLE significance_cols AS
SELECT SQLDATE,
       AVG(NumMentions) AS avg_num_mentions,
       stddev_samp(NumMentions) AS stddev_num_mentions,
       AVG(NumArticles) AS avg_num_articles,
       stddev_samp(NumArticles) AS stddev_num_articles,
       AVG(NumSources) AS avg_num_sources,
       stddev_samp(NumSources) AS stddev_num_sources
FROM usa_conflict_events 
GROUP BY SQLDATE;


ALTER TABLE usa_conflict_events ADD COLUMN std_num_mentions decimal(10,4);
ALTER TABLE usa_conflict_events ADD COLUMN std_num_articles decimal(10,4);
ALTER TABLE usa_conflict_events ADD COLUMN std_num_sources decimal(10,4);

UPDATE usa_conflict_events e
SET 
  e.std_num_mentions=(
    SELECT (e.NumMentions - s.avg_num_mentions)/s.stddev_num_mentions
    FROM significance_cols s
    WHERE s.SQLDATE=e.SQLDATE),
  e.std_num_articles=(
    SELECT (e.NumArticles - s.avg_num_articles)/s.stddev_num_articles
    FROM significance_cols s
    WHERE s.SQLDATE=e.SQLDATE),
  e.std_num_sources=(
    SELECT (e.NumSources - s.avg_num_sources)/s.stddev_num_sources
    FROM significance_cols s
    WHERE s.SQLDATE=e.SQLDATE);
