CREATE VIEW events_215125_28 AS 
  SELECT * FROM events WHERE SQLDATE > 215124 AND EventRootCode is not NULL;

DROP TABLE event_type_counts;

CREATE TABLE if not exists event_type_counts AS
  SELECT count(*),
  CASE EventRootCode
    WHEN 1 THEN "public_statement"
    WHEN 2 THEN "appeal"
    WHEN 3 THEN "intent_to_cooperate"
    WHEN 4 THEN "consult"
    WHEN 5 THEN "diplomatic_cooperation"
    WHEN 6 THEN "material_cooperation"
    WHEN 7 THEN "provide_aid"
    WHEN 8 THEN "yield"
    WHEN 9 THEN "investigate"
    WHEN 10 THEN "demand"
    WHEN 11 THEN "disapprove"
    WHEN 12 THEN "reject"
    WHEN 13 THEN "threaten"
    WHEN 14 THEN "protest"
    WHEN 15 THEN "exhibit_force"
    WHEN 16 THEN "reduce_relations"
    WHEN 17 THEN "coerce"
    WHEN 18 THEN "assault"
    WHEN 19 THEN "fight"
    WHEN 20 THEN "mass_violence"
    ELSE NULL
  END AS EventType
  FROM events GROUP BY EventRootCode;

DROP TABLE IF EXISTS count_events_grouped_by_day;

CREATE TABLE count_events_grouped_by_day AS
  SELECT SQLDATE, count(*) AS total_events FROM random_events GROUP BY SQLDATE;
