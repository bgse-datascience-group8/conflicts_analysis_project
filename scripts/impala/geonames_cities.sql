-- reference http://geonames.usgs.gov/domestic/metadata.htm
-- COMMANDS
-- wget http://download.geonames.org/export/dump/cities15000.zip
-- unzip cities15000.zip 
-- sed 's/\t/|/g' cities15000.txt > no-tab-cities15000.txt # boooo
-- REMOVE Eixample, makes impala mad `:/
-- hadoop fs -mkdir /user/gdelt/geonames_cities
-- hadoop fs -put no-tab-cities15000.txt /user/gdelt/geonames_cities/no-tab-cities15000.txt
-- (impala-shell)
--
create database gdelt location '/user/gdelt';
use gdelt;

DROP TABLE IF EXISTS geonames_cities;

CREATE EXTERNAL TABLE geonames_cities (
  `geonameid` STRING,
  `name` STRING,
  `asciiname` STRING,
  `alternatenames` STRING,
  `latitude` DOUBLE,
  `longitude` DOUBLE,
  `feature_class` STRING,
  `feature_code` STRING,
  `country_code` STRING,
  `cc2` STRING,
  `admin1_code` STRING,
  `admin2_code` STRING ,
  `admin3_code` STRING,
  `admin4_code` STRING,
  `population` STRING,
  `elevation_meters` STRING,
  `dem` STRING,
  `timezone` STRING,
  `modification` STRING 
)
row format delimited
fields terminated by '|'
stored as textfile
location '/user/gdelt/geonames_cities';

-- Query OK, 23477 rows affected, 65535 warnings (0.27 sec)
-- Records: 23477  Deleted: 0  Skipped: 0  Warnings: 399501
