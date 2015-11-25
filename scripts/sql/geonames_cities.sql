DROP TABLE IF EXISTS geonames_cities;

CREATE TABLE geonames_cities (
  geonameid int(11),
  name varchar(200),
  asciiname varchar(200),
  alternatenames varchar(10000),
  latitude double,
  longitude double,
  feature_class char(1),
  feature_code varchar(10),
  country_code varchar(2),
  cc2 varchar(200),
  admin1_code varchar(20),
  admin2_code varchar(80) ,
  admin3_code varchar(20),
  admin4_code varchar(20),
  population integer,
  elevation_meters integer,
  dem integer,
  timezone varchar(40),
  modification date
);

LOAD DATA INFILE '/Users/aimeebarciauskas/Projects/data_files/cities15000.txt'
IGNORE INTO TABLE geonames_cities
FIELDS TERMINATED BY '\t'
LINES TERMINATED BY '\n';

-- Query OK, 23477 rows affected, 65535 warnings (0.27 sec)
-- Records: 23477  Deleted: 0  Skipped: 0  Warnings: 399501
