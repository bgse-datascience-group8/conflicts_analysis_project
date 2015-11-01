CREATE TABLE random_events AS
SELECT *
  FROM events WHERE EventRootCode is not NULL
 ORDER BY RAND()
 LIMIT 20000;
