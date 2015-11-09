# Notes from Exploration

## Importing data

Script use for data import into RDS: [importGdeltData.R](../scripts/importGdeltData.R)

* `time`: Importing data into RDS took about 180 minutes for 1 year (15 minutes per month, using an m4.xlarge)
* `size`: Each month of data takes ~3GB of storage space

**Update 08 Nov 2015** Imported all data since April 2013.

## TODO:

* Adapt script to:
    * Create table with GLOBALEVENTID uniqueness constraint?
    * Import data with schema and indices? (which are the best indices?)
    * Prossibly import data into partitioned (monthly) tables?
    * Limit import to events with some qualification of significance?
