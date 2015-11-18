## BEGIN EMR SCRIPTS
hadoop fs -mkdir /user/gdelt
hadoop fs -chmod 777 /user/gdelt

wget http://www.eu.apache.org/dist/sqoop/1.4.6/sqoop-1.4.6.bin__hadoop-2.0.4-alpha.tar.gz
tar -xzf sqoop-1.4.6.bin__hadoop-2.0.4-alpha.tar.gz

wget http://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-5.1.37.zip
unzip mysql-connector-java-5.1.37.zip

cp mysql-connector-java-5.1.37/mysql-connector-java-5.1.37-bin.jar sqoop-1.4.6.bin__hadoop-2.0.4-alpha/lib/

./sqoop-1.4.6.bin__hadoop-2.0.4-alpha/bin/sqoop import \
  --connect jdbc:mysql://group8-db.cgwo8rgbvpyh.eu-west-1.rds.amazonaws.com:3306/gdelt \
  -username group8 -password $DB_PASSWORD \
  --target-dir /user/gdelt/events \
  --fields-terminated-by "|" \
  --null-string '\\N' --null-non-string '\\N' \
  --table events \
  --direct -m 1

./sqoop-1.4.6.bin__hadoop-2.0.4-alpha/bin/sqoop export \
  --connect jdbc:mysql://group8-gdelt.cgwo8rgbvpyh.eu-west-1.rds.amazonaws.com:3306/gdelt \
  -username group8 -password $DB_PASSWORD \
  --table 'usa_conflict_events' \
  --export-dir /user/gdelt/usa_conflict_events \
  --direct -m 4 \
  --fields-terminated-by "|"
## END EMR SCRIPTS


## BEGIN CLOUDERA SCRIPTS
# Missing import of usa_conflict events
sudo -u hdfs hdfs dfs -mkdir /user/gdelt
sudo -u hdfs hdfs dfs -chmod 777 /user/gdelt

sqoop export \
  --connect jdbc:mysql://group8-gdelt.cgwo8rgbvpyh.eu-west-1.rds.amazonaws.com:3306/gdelt \
  -username group8 -password $DB_PASSWORD \
  --table 'usa_conflict_events_v3' \
  --export-dir /user/gdelt/usa_conflict_events_v3 \
  --direct -m 4 \
  --fields-terminated-by "|"
## END CLOUDERA SCRIPTS


## BEGIN MORE EMR SCRIPTS
./sqoop-1.4.6.bin__hadoop-2.0.4-alpha/bin/sqoop import \
  --connect jdbc:mysql://group8-gdelt.cgwo8rgbvpyh.eu-west-1.rds.amazonaws.com:3306/gdelt \
  -username group8 -password $DB_PASSWORD \
  --target-dir /user/gdelt/usa_conflict_events_v3 \
  --fields-terminated-by "|" \
  --null-string '\\N' --null-non-string '\\N' \
  --table usa_conflict_events_v3 \
  --split-by SQLDATE

./sqoop-1.4.6.bin__hadoop-2.0.4-alpha/bin/sqoop export \
  --connect jdbc:mysql://group8-gdelt.cgwo8rgbvpyh.eu-west-1.rds.amazonaws.com:3306/gdelt \
  -username group8 -password $DB_PASSWORD \
  --table 'city_day_event_counts' \
  --export-dir /user/gdelt/city_day_event_counts \
  --direct -m 4 \
  --fields-terminated-by "|"
## END MORE IMPALA SCRIPTS
