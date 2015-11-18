DROP TABLE IF EXISTS events_with_cities;

CREATE TABLE events_with_cities AS
SELECT usa_conflict_events_v3.*, gnis_cities.*
FROM usa_conflict_events_v3
JOIN gnis_cities
ON usa_conflict_events_v3.ActionGeo_FeatureID=gnis_cities.feature_id;
