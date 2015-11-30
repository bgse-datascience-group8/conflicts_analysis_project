---
title: "SPACE"
author: "Aimee Barciauskas"
date: "November 28, 2015"
output: html_document
---

```{r, echo = FALSE}
library(RMySQL)
library(reshape)
library(ggplot2)
library(dplyr)

con <- dbConnect(RMySQL::MySQL(), user="root", password="root", dbname = "gdelt")

res <- dbSendQuery(con, "select * from top_cities where sqldate > 20130401")
data <- dbFetch(res, n = -1)

# Standard data formatting
data$datef <- as.Date(as.character(data$sqldate), format = '%Y%m%d')
data$city <- paste0(data$name, ', ', data$admin1_code)

## Removing Washington, D.C. (for now)
data <- subset(data, geonameid != '4140963')

day_means <- tapply(data$num_conflicts, data$sqldate, FUN=mean)
day_means <- cbind(as.matrix(day_means), as.numeric(row.names(day_means)))
colnames(day_means) <- c('date_mean','sqldate')

day_sds <- tapply(data$num_conflicts, data$sqldate, FUN=sd)
day_sds <- cbind(as.matrix(day_sds), as.numeric(row.names(day_sds)))
colnames(day_sds) <- c('date_sd','sqldate')

data <- merge(data, day_means, by = 'sqldate', all.x = TRUE)
data <- merge(data, day_sds, by = 'sqldate', all.x = TRUE)

data$std_num_conflicts <- (data$num_conflicts - data$date_mean)/data$date_sd
```

Melt data into cities x cities

```{r, echo=FALSE}
library(reshape2)
date_by_city_matrix <- data[,c('std_num_conflicts','datef','city')]

# fun aggregate needed as some cells are not represented -> 0
events_by_date_city <- dcast(data = date_by_city_matrix, formula = datef ~ city, value.var = 'std_num_conflicts', fun.aggregate = sum)

# Sanity check
# head(events_by_date_city[,'Tulsa, OK'], n = 20)
# head(data[data$city == 'Tulsa, OK',][,c('std_num_conflicts','datef')], n = 10)

# Make date column rownames
rownames(events_by_date_city) <- events_by_date_city$datef
events_by_date_city <- events_by_date_city[,setdiff(colnames(events_by_date_city), 'datef')]

X <- events_by_date_city
```