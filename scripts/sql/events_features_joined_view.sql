DROP TABLE IF EXISTS events_features_joined;
CREATE TABLE events_features_joined AS
SELECT random_events.*,
  gnis_feature_ids.FEATURE_ID,
  gnis_feature_ids.FEATURE_NAME ,
  gnis_feature_ids.FEATURE_CLASS,
  gnis_feature_ids.STATE_ALPHA,
  gnis_feature_ids.STATE_NUMERIC,
  gnis_feature_ids.COUNTY_NAME,
  gnis_feature_ids.COUNTY_NUMERIC,
  gnis_feature_ids.PRIMARY_LAT_DMS,
  gnis_feature_ids.PRIM_LONG_DMS,
  gnis_feature_ids.PRIM_LAT_DEC,
  gnis_feature_ids.PRIM_LONG_DEC,
  gnis_feature_ids.SOURCE_LAT_DMS ,
  gnis_feature_ids.SOURCE_LONG_DMS,
  gnis_feature_ids.SOURCE_LAT_DEC,
  gnis_feature_ids.SOURCE_LONG_DEC,
  gnis_feature_ids.ELEV_IN_M,
  gnis_feature_ids.ELEV_IN_FT,
  gnis_feature_ids.MAP_NAME ,
  gnis_feature_ids.DATE_CREATED ,
  gnis_feature_ids.DATE_EDITED
FROM random_events
LEFT JOIN gnis_feature_ids
ON random_events.ActionGeo_FeatureID = gnis_feature_ids.FEATURE_ID;
