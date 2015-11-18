# Connect to remote (on remote ec2)
mysql --host=group8-gdelt.cgwo8rgbvpyh.eu-west-1.rds.amazonaws.com --user=group8 --password=$DB_PASSWORD gdelt

# Dump on remote
mysqldump --host=group8-db.cgwo8rgbvpyh.eu-west-1.rds.amazonaws.com --user=group8 --password=$DB_PASSWORD gdelt usa_events_subset_random > usa_events_subset_random.sql

# Copy down dump file
scp ubuntu@52.17.60.129:~/random_events_dump.sql .

# Dump into local
mysql -uroot -p gdelt < random_events_dump.sql
