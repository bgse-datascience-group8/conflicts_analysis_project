# Notes from Exploration

## Importing data

Script use for data import into RDS: [importGdeltData.R](../scripts/importGdeltData.R)

* `time`: Importing data into RDS takes ??
* `size`: Each month of data takes ~3GB of storage space

## TODO:

* Adapt script to:
    * Import data in range of days
    * Create table with GLOBALEVENTID uniqueness constraint
    * Prossibly import data into partitioned (monthly) tables
