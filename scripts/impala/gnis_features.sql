-- reference http://geonames.usgs.gov/domestic/metadata.htm
-- COMMANDS
-- wget http://geonames.usgs.gov/docs/stategaz/NationalFile_20151001.zip
-- unzip NationalFile_20151001.zip
-- hadoop fs -mkdir /user/gdelt/gnis_features
-- have to remove first line
-- hadoop fs -put NationalFile_20151001.txt /user/gdelt/gnis_features/NationalFile_20151001.txt
-- (impala-shell)
create database gdelt location '/user/gdelt';
use gdelt;

CREATE TABLE gnis_features (
  `FEATURE_ID` STRING, -- 1 to 9,999,999,999,999
  `FEATURE_NAME` STRING,
  `FEATURE_CLASS` STRING,
  `STATE_ALPHA` STRING,
  `STATE_NUMERIC` STRING,
  `COUNTY_NAME` STRING,
  `COUNTY_NUMERIC` STRING,
  `PRIMARY_LAT_DMS` STRING,
  `PRIM_LONG_DMS` STRING,
  `PRIM_LAT_DEC` STRING,
  `PRIM_LONG_DEC` STRING,
  `SOURCE_LAT_DMS` STRING,
  `SOURCE_LONG_DMS` STRING,
  `SOURCE_LAT_DEC` STRING,
  `SOURCE_LONG_DEC` STRING,
  `ELEV_IN_M` STRING,
  `ELEV_IN_FT` STRING,
  `MAP_NAME` STRING,
  `DATE_CREATED` STRING,
  `DATE_EDITED` STRING
)
row format delimited
fields terminated by '|'
stored as textfile
location '/user/gdelt/gnis_features';

SELECT DISTINCT(FEATURE_CLASS) FROM gnis_features;

CREATE TABLE gnis_cities AS (
  SELECT * FROM gnis_features WHERE FEATURE_CLASS = 'Populated Place'
);
