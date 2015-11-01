# Connect to remote (on remote ec2)
mysql --host=ds-group8.cgwo8rgbvpyh.eu-west-1.rds.amazonaws.com --user=group8 --password=$DB_PASSWORD gdelt

# Dump on remote
mysqldump --host=ds-group8.cgwo8rgbvpyh.eu-west-1.rds.amazonaws.com --user=group8 --password=$DB_PASSWORD gdelt random_events > random_events_dump.sql

# Copy down dump file
scp ubuntu@52.17.60.129:~/random_events_dump.sql .

# Dump into local
mysql -uroot -p < random_events_dump.sql
