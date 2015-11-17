create table gnis_features_cities as (select * from gnis_features where FEATURE_CLASS = 'Populated Place');

DROP TABLE IF EXISTS events_with_cities;
CREATE TABLE events_with_cities AS
SELECT usa_events_subset_random.*, gnis_features_cities.*
FROM usa_events_subset_random
LEFT JOIN gnis_features_cities
ON usa_events_subset_random.ActionGeo_FeatureID = gnis_features_cities.FEATURE_ID;
