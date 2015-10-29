CREATE VIEW events_215125_28 AS 
  SELECT * FROM events WHERE SQLDATE > 215124 AND EventRootCode is not NULL;

CREATE VIEW event_type_counts AS
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



CREATE VIEW public_statement_events AS
  SELECT * FROM events WHERE EventRootCode = 1;

CREATE VIEW provide_aid_events AS
  SELECT * FROM events WHERE EventRootCode = 7;

CREATE VIEW demand_events AS
  SELECT * FROM events WHERE EventRootCode = 10;

CREATE VIEW disapprove_events AS
  SELECT * FROM events WHERE EventRootCode = 11;

CREATE VIEW reject_events AS
  SELECT * FROM events WHERE EventRootCode = 12;

CREATE VIEW reject_events AS
  SELECT * FROM events WHERE EventRootCode = 12;

CREATE VIEW protest_events AS
  SELECT * FROM events WHERE EventRootCode = 14;
