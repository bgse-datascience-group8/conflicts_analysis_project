#### Results from Google Big Query
#
SELECT COUNT(DISTINCT(GLOBALEVENTID))
FROM
  [gdelt-bq:full.events] WHERE SQLDATE > 20130401;
-- 129,486,192

and ActionGeo_CountryCode='US';
-- 44,131,125

# Maybe??
AND (QuadClass = 3 OR QuadClass = 4);
-- 11,387,575


