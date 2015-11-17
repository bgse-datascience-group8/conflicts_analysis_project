-- downloaded & unzip http://geonames.usgs.gov/docs/stategaz/NationalFile_20151001.zip
-- reference http://geonames.usgs.gov/domestic/metadata.htm
--
DROP TABLE IF EXISTS gnis_features;

CREATE TABLE gnis_features (
  `FEATURE_ID` varchar(13), -- 1 to 9,999,999,999,999
  PRIMARY KEY (FEATURE_ID),
  `FEATURE_NAME` text,
  `FEATURE_CLASS` text,
  `STATE_ALPHA` text,
  `STATE_NUMERIC` bigint(20) DEFAULT NULL,
  `COUNTY_NAME` text,
  `COUNTY_NUMERIC` bigint(20) DEFAULT NULL,
  `PRIMARY_LAT_DMS` text,
  `PRIM_LONG_DMS` text,
  `PRIM_LAT_DEC` bigint(20) DEFAULT NULL,
  `PRIM_LONG_DEC` bigint(20) DEFAULT NULL,
  `SOURCE_LAT_DMS` text,
  `SOURCE_LONG_DMS` text,
  `SOURCE_LAT_DEC` bigint(20) DEFAULT NULL,
  `SOURCE_LONG_DEC` bigint(20) DEFAULT NULL,
  `ELEV_IN_M` bigint(20) DEFAULT NULL,
  `ELEV_IN_FT` bigint(20) DEFAULT NULL,
  `MAP_NAME` text,
  `DATE_CREATED` text,
  `DATE_EDITED` text
);

LOAD DATA INFILE '/Users/aimeebarciauskas/Projects/data_files/NationalFile_20151001.txt'
IGNORE INTO TABLE gnis_features
FIELDS TERMINATED BY '|'
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
  (FEATURE_ID,FEATURE_NAME,FEATURE_CLASS,STATE_ALPHA,STATE_NUMERIC,COUNTY_NAME,@COUNTY_NUMERIC,PRIMARY_LAT_DMS,PRIM_LONG_DMS,PRIM_LAT_DEC,PRIM_LONG_DEC,SOURCE_LAT_DMS,SOURCE_LONG_DMS,@SOURCE_LAT_DEC,@SOURCE_LONG_DEC,@ELEV_IN_M,@ELEV_IN_FT,MAP_NAME,DATE_CREATED,DATE_EDITED)
  set SOURCE_LAT_DEC=nullif(@SOURCE_LAT_DEC,''),
      COUNTY_NUMERIC=nullif(@COUNTY_NUMERIC,''),
      ELEV_IN_M=nullif(@ELEV_IN_M,''),
      ELEV_IN_FT=nullif(@ELEV_IN_FT,'');

-- Query OK, 1921642 rows affected, 15 warnings (21.95 sec)
-- Records: 1921704  Deleted: 0  Skipped: 62  Warnings: 15
