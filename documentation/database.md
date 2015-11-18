# Database Design

## Description

The table on which we run our analysis has the following structure:

```sql
MySQL [gdelt]> describe city_day_event_counts;
+---------------------------------+------------+------+-----+---------+-------+
| Field                           | Type       | Null | Key | Default | Extra |
+---------------------------------+------------+------+-----+---------+-------+
| num_conflicts                   | bigint(20) | YES  |     | NULL    |       |
| sum_squared_significance_scores | double     | YES  |     | NULL    |       |
| sqldate                         | bigint(20) | YES  |     | NULL    |       |
| feature_name                    | text       | YES  |     | NULL    |       |
| feature_id                      | text       | YES  |     | NULL    |       |
| state_alpha                     | text       | YES  |     | NULL    |       |
| county_name                     | text       | YES  |     | NULL    |       |
| prim_lat_dec                    | double     | YES  |     | NULL    |       |
| prim_long_dec                   | double     | YES  |     | NULL    |       |
+---------------------------------+------------+------+-----+---------+-------+
9 rows in set (0.01 sec)
```

Feature name is equivalent to city name.

## Data origin

In order to understand the spatial-temporal relationship of conflict events in the United States from April 2013 until the recent past, the application is built on an aggregated subset of the GDELT database.

The GDELT Project collects and stores events gathered from many different news media, including broadcast, web and print. It identifies attributes of the event, such as actors, locations and significance and categorizes each into an event hierarchy.

The data is subset based on the following criteria:

* **Events ocurring on or after 1 April 2013:** We exclude any events ocurring before April 2013 for two important reasons. The first is this is when data collection by GDELT started and all events prior have been back-filled. Second, there is no SOURCEURL field. The SOURCEURL field is an important field for sanity-checking the original source of events.
* **Events within the United States:** We are limiting the scope of our analysis to events ocurring within the United States (e.g. Actor1Geo_Country and Actor2Geo_Country = 'US').
* **Events with a QuadClass of 3 or 4:** The QuadClass field is the highest level of the event type hierarchy and includes only the values 1=Verbal Cooperation, 2=Material Cooperation, 3=Verbal Conflict, 4=Material Conflict.

After subsetting the table, additional steps are required to build the conflict analysis database. These are described below in **[Database Scripts](#database-scripts)**.

Below summarizes the tables used to compose the final table:

![Data Model](https://www.lucidchart.com/publicSegments/view/7b894595-a078-49de-b988-d339afbd4fcc/image.png)

## Database Scripts

The process for building the conflict analysis database is as follows:

**1. BGSE EC2 AMI & R:** Import data from GDELT website server to RDS

[`/scripts/importGdeltData.R`](/scripts/importGdeltData.R)

**2. Sqoop:** Sqoop data in and out of RDS and HDFS

[`/scripts/shell/sqoop-import.sh`](/scripts/shell/sqoop-import.sh)

**3. EMR Impala** Build events table and subset to conflict events in the US

[`/scripts/impala/events_to_usa_conflict_events.sql`](/scripts/impala/events_to_usa_conflict_events.sql)

**4. Cloudera Impala:** Add standardized columns of significance metrics (`NumMentions`, `NumArticles`, `NumSources`) and sum standardized columns as significance measure

[`/scripts/impala/significance_cols.sql`](/scripts/impala/significance_cols.sql)

**5. EMR Impala:** Download and create the `gnis_features` table using [`/scripts/impala/gnis_features.sql`](/scripts/sql/gnis_features.sql). Subset features to cities (e.g. `FEATURE_CLASS = 'Populated Place'`).

**6. EMR Impala:** Join events with features to create `events_with_cities` table

[`/scripts/impala/events_with_cities.sql`](/scripts/impala/events_with_cities.sql)

**7. EMR Impala:** Create the city-date counts table

[`/scripts/impala/city_day_event_counts.sql`](/scripts/sql/impala/city_day_event_counts.sql)

At different stages, we use either the Cloudera AMI or AWS EMR because we needed the power of scaling (EMR) or required a more recent version of Impala (Cloudera) to make use of the STDDEV function that is not available in EMR's current 1.2.4 version of Impala.


#### Final script

The final dump file of the [`/data/city_day_event_counts.sql`](/data/city_day_event_counts.sql) table is used in the application and our analysis.
