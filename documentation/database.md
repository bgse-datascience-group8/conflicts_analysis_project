# Database Design

## Description

The GDELT Project collects and stores events gathered from many different news media, including broadcast, web and print. It identifies attributes of the event, such as actors, locations and significance and categorizes each into an event hierarchy.

The mysql table on which we run our analysis has the following structure:

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

Feature name is equivalent to city name in this case.

In order to understand the spatial-temporal relationship of conflict events in the United States from April 2013 until the recent past, the application will be built on a subset of the GDELT database. The data is subset based on the following criteria:

* **Events ocurring on or after 1 April 2013:** We exclude any events ocurring before April 2013 for two important reasons. The first is this is when data collection by GDELT started and all events prior have been back-filled. Second, there is no SOURCEURL field. The SOURCEURL field is an important field for sanity-checking the original source of events.
* **Events within the United States:** We are limiting the scope of our analysis to events ocurring within the United States (e.g. Actor1Geo_Country and Actor2Geo_Country = 'US').
* **Events with a QuadClass of 3 or 4:** The QuadClass field is the highest level of the event type hierarchy and includes only the values 1=Verbal Cooperation, 2=Material Cooperation, 3=Verbal Conflict, 4=Material Conflict.

After subsetting the table, additional steps are required to build the conflict analysis database. These are described below in [Database Scripts](#database-scripts)

To be able to estimate the geo-spatial effects, the following data model is used:

![Data Model](https://www.lucidchart.com/publicSegments/view/8c882a94-612a-463a-9802-0a72a6c928dc/image.png)

## Database Scripts

The process for building the conflict analysis database is as follows:

1. Imported data into RDS since April 2013 using [`scripts/importGdeltData.R`](./scripts/importGdeltData.R)
2. **Sqooped** data in and out of RDS and HDFS [`scripts/shell/sqoop-import.sh`](./scripts/shell/sqoop-import.sh)
3. **EMR Impala-shell** built events table and subset to conflict events in the US [`scripts/sql/impala_events_to_usa_conflict_events.sql`](./scripts/sql/impala_events_to_usa_conflict_events.sql)
5. **Cloudera Impala-shell** Add standardized columns of significance metrics (`NumMentions`, `NumArticles`, `NumSources`) and sum standardized columns as significance measure: []()
7. GNIS...
8. Create aggregate table `city_day_conflict_counts`
9. exported result tables back into RDS (see sqoop script)


1. Download [GNIS features file](http://geonames.usgs.gov/docs/stategaz/NationalFile_20151001.zip)
2. Create the `gnis_features` table using [`scripts/sql/create_gnis_features.sql`](./scripts/sql/create_gnis_features.sql)
3. Import the data [`scripts/sql/create_gnis_features.sql`](./scripts/sql/create_gnis_features.sql)
4. Subset the features to only those of type 'populated place' (e.g. cities) and create the `events_with_cities` table [scripts/sql/events_features_joined_view.sql](./scripts/sql/events_features_joined_view.sql)

**EMR Impala-shell** Create the city-date counts table [scripts/sql/conflict_events_city_day_counts.sql](./scripts/sql/impala_city_day_event_counts.sql)

**Footnote to 2:** At different stages, we use either the Cloudera AMI or AWS EMR because we needed the power of scaling (EMR) or required a more recent version of Impala (Cloudera) to make use of the STDDEV function that is not available in EMR's current 1.2.4 version of Impala.


#### Final script

The final dump file of the [`city_day_event_counts.sql`](./data/city_day_event_counts.sql) table is used in the application and our analysis.
