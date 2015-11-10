sudo -u hdfs hdfs dfs -mkdir /user/gdelt
sudo -u hdfs hdfs dfs -chmod 777 /user/gdelt

wget http://www.eu.apache.org/dist/sqoop/1.4.6/sqoop-1.4.6.bin__hadoop-2.0.4-alpha.tar.gz
tar -xzf sqoop-1.4.6.bin__hadoop-2.0.4-alpha.tar.gz

wget http://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-5.1.37.zip
tar -xzf mysql-connector-java-5.1.37.zip

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
  --connect jdbc:mysql://group8-db.cgwo8rgbvpyh.eu-west-1.rds.amazonaws.com:3306/gdelt \
  -username group8 -password $DB_PASSWORD \
  --table 'usa_events_subset_random' \
  --export-dir /user/gdelt/usa_events_subset_random \
  --direct -m 4 \
  --fields-terminated-by "|"