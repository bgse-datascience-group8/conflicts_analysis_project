#### Results from impala!
#
create database gdelt location '/user/gdelt';
use gdelt;

## Create table file..

select count(*) from events;
-- Query: select count(*) from events
-- +-----------+
-- | count(*)  |
-- +-----------+
-- | 130753485 |
-- +-----------+
-- Returned 1 row(s) in 25.56s
