# Notes from Exploration

## Importing data

Script use for data import into RDS: [importGdeltData.R](../scripts/importGdeltData.R)

* `time`: Importing data into RDS took about 180 minutes for 1 year (15 minutes per month, using an m4.xlarge)
* `size`: Each month of data takes ~3GB of storage space

**Update 08 Nov 2015** Imported all data since April 2013.

### Process for importing data

1. imported data into RDS since April 2013 using `scripts/importGdeltData.R`
2. started emr cluster with 4 data nodes ![cluster configuration](cluster-config.png)
3. sqooped data into hdfs `scripts/sqoop-import.sh`
4. built events table using impalal `scripts/impala-queries.sql`
5. subset events in the US (see impala queries script)
6. subset events in the US into random subset of a workable size
7. exported tables resulting from 5 and 6 back into RDS (see sqoop script)

## Data Fields / Data Decisions

**FeatureID** Used to determine city of event. This is advised by GDELT's Data Format Codebook

> To find all events located in or relating to a specific city or geographic landmark, the Geo_FeatureID column should be used, rather than the Geo_Fullname column. This is because the Geo_Fullname column captures the name of the location as expressed in the text and thus reflects differences in transliteration, alternative spellings, and alternative names for the same location. (page 5)

**Actor1Geo\_CountryCode and Actor2Geo\_CountryCode** Sounds like we should use Actor* as advised in Codebook:

> When looking for events in or relating to a specific country, such as Syria, there are two possible filtering methods. The first is to use the Actor_CountryCode fields in the Actor section to look for all actors having the SYR (Syria) code. However, conflict zones are often accompanied by high degrees of uncertainty in media reporting and a news article might mention only “Unidentified gunmen stormed a house and shot 12 civilians.” In this case, the Actor_CountryCode fields for Actor1 and Actor2 would both be blank, since the article did not specify the actor country affiliations, while their Geo_CountryCode values (and the ActorGeo_CountryCode for the event) would specify Syria. This can result in dramatic differences when examining active conflict zones. The second method is to examine the ActorGeo_CountryCode for the location of the event. This will also capture situations such as the United States criticizing a statement by Russia regarding a specific Syrian attack. (page 5)

**Event Codes** Complete description is found pages 6/13 - 87 in CAMEO Manual.

