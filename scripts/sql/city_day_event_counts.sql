CREATE TABLE city_day_event_counts (
  num_conflicts BIGINT, 
  sum_num_mentions DOUBLE,
  sum_num_articles DOUBLE,
  sum_num_sources DOUBLE,
  sqldate BIGINT, 
  feature_name text, 
  feature_id text, 
  state_alpha text, 
  county_name text, 
  prim_lat_dec DOUBLE, 
  prim_long_dec DOUBLE);