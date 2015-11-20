CREATE TABLE events_with_cities (
  row_names text,
  globaleventid BIGINT,
  sqldate BIGINT,
  monthyear BIGINT,
  year BIGINT,
  fractiondate text,
  actor1code text,
  actor1name text,
  actor1countrycode text,
  actor1knowngroupcode text,
  actor1ethniccode text,
  actor1religion1code text,
  actor1religion2code text,
  actor1type1code text,
  actor1type2code text,
  actor1type3code text,
  actor2code text,
  actor2name text,
  actor2countrycode text,
  actor2knowngroupcode text,
  actor2ethniccode text,
  actor2religion1code text,
  actor2religion2code text,
  actor2type1code text,
  actor2type2code text,
  actor2type3code text,
  isrootevent BIGINT,
  eventcode BIGINT,
  eventbasecode BIGINT,
  eventrootcode BIGINT,
  quadclass BIGINT,
  goldsteinscale text,
  nummentions BIGINT,
  numsources BIGINT,
  numarticles BIGINT,
  avgtone text,
  actor1geo_type BIGINT,
  actor1geo_fullname text,
  actor1geo_countrycode text,
  actor1geo_adm1code text,
  actor1geo_lat text,
  actor1geo_long text,
  actor1geo_featureid text,
  actor2geo_type BIGINT,
  actor2geo_fullname text,
  actor2geo_countrycode text,
  actor2geo_adm1code text,
  actor2geo_lat text,
  actor2geo_long text,
  actor2geo_featureid text,
  actiongeo_type BIGINT,
  actiongeo_fullname text,
  actiongeo_countrycode text,
  actiongeo_adm1code text,
  actiongeo_lat text,
  actiongeo_long text,
  actiongeo_featureid text,
  dateadded BIGINT,
  sourceurl text,
  std_num_mentions FLOAT, 
  std_num_articles FLOAT, 
  std_num_sources FLOAT, 
  significance_score FLOAT, 
  feature_id text,
  feature_name text,
  feature_class text,
  state_alpha text,
  state_numeric text,
  county_name text,
  county_numeric text,
  primary_lat_dms text,
  prim_long_dms text,
  prim_lat_dec text,
  prim_long_dec text,
  source_lat_dms text,
  source_long_dms text,
  source_lat_dec text,
  source_long_dec text,
  elev_in_m text,
  elev_in_ft text,
  map_name text,
  date_created text,
  date_edited text
);  