DROP TABLE IF EXISTS usa_conflict_events_v3;

CREATE TABLE `usa_conflict_events_v3` (
  `row_names` text,
  `GLOBALEVENTID` bigint(20) DEFAULT NULL,
  `SQLDATE` bigint(20) DEFAULT NULL,
  `MonthYear` bigint(20) DEFAULT NULL,
  `Year` bigint(20) DEFAULT NULL,
  `FractionDate` double DEFAULT NULL,
  `Actor1Code` text,
  `Actor1Name` text,
  `Actor1CountryCode` text,
  `Actor1KnownGroupCode` text,
  `Actor1EthnicCode` text,
  `Actor1Religion1Code` text,
  `Actor1Religion2Code` text,
  `Actor1Type1Code` text,
  `Actor1Type2Code` text,
  `Actor1Type3Code` text,
  `Actor2Code` text,
  `Actor2Name` text,
  `Actor2CountryCode` text,
  `Actor2KnownGroupCode` text,
  `Actor2EthnicCode` text,
  `Actor2Religion1Code` text,
  `Actor2Religion2Code` text,
  `Actor2Type1Code` text,
  `Actor2Type2Code` text,
  `Actor2Type3Code` text,
  `IsRootEvent` bigint(20) DEFAULT NULL,
  `EventCode` bigint(20) DEFAULT NULL,
  `EventBaseCode` bigint(20) DEFAULT NULL,
  `EventRootCode` bigint(20) DEFAULT NULL,
  `QuadClass` bigint(20) DEFAULT NULL,
  `GoldsteinScale` double DEFAULT NULL,
  `NumMentions` bigint(20) DEFAULT NULL,
  `NumSources` bigint(20) DEFAULT NULL,
  `NumArticles` bigint(20) DEFAULT NULL,
  `AvgTone` double DEFAULT NULL,
  `Actor1Geo_Type` bigint(20) DEFAULT NULL,
  `Actor1Geo_FullName` text,
  `Actor1Geo_CountryCode` text,
  `Actor1Geo_ADM1Code` text,
  `Actor1Geo_Lat` double DEFAULT NULL,
  `Actor1Geo_Long` double DEFAULT NULL,
  `Actor1Geo_FeatureID` varchar(13),
  `Actor2Geo_Type` bigint(20) DEFAULT NULL,
  `Actor2Geo_FullName` text,
  `Actor2Geo_CountryCode` text,
  `Actor2Geo_ADM1Code` text,
  `Actor2Geo_Lat` double DEFAULT NULL,
  `Actor2Geo_Long` double DEFAULT NULL,
  `Actor2Geo_FeatureID` varchar(13),
  `ActionGeo_Type` bigint(20) DEFAULT NULL,
  `ActionGeo_FullName` text,
  `ActionGeo_CountryCode` text,
  `ActionGeo_ADM1Code` text,
  `ActionGeo_Lat` double DEFAULT NULL,
  `ActionGeo_Long` double DEFAULT NULL,
  `ActionGeo_FeatureID` varchar(13),
  `DATEADDED` bigint(20) DEFAULT NULL,
  `SOURCEURL` text,
  `std_num_mentions` double DEFAULT NULL,
  `std_num_articles` double DEFAULT NULL,
  `std_num_sources` double DEFAULT NULL,
  `significance_score` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
