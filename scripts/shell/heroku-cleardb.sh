heroku addons:create cleardb:ignite

# DUMP
mysql --host=us-cdbr-iron-east-03.cleardb.net --user=bba69ffc41f71d --password=$CLEARDB_PASSWORD \
  heroku_40d01d5bed13db1 < city_day_event_counts_plus.sql

# CONNECT
mysql --host=us-cdbr-iron-east-03.cleardb.net --user=bba69ffc41f71d --password=$CLEARDB_PASSWORD heroku_40d01d5bed13db1
