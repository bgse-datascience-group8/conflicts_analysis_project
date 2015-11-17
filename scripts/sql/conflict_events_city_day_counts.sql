DROP TABLE IF EXISTS conflict_events_city_day_counts;
CREATE TABLE conflict_events_city_day_counts AS
  SELECT COUNT(*), SQLDATE, FEATURE_NAME FROM events_features_joined GROUP BY FEATURE_NAME, SQLDATE;
