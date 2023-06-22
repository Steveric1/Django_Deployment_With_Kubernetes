#!/bin/bash

#Extract the database name from the url
db_name=$(echo $DATABASE_URL | awk -F'/' '{print $NF}')

#check if the database is already exist
if mysqlshow -u admin -p ${DATABASE_PASSWORD} ${db_name} > /dev/null; then
    echo "Database already exists"
else 
    echo "Database does not exist, creating..."
    echo "CREATE DATABASE ${db_name};" | mysql -u admin -p ${DATABASE_PASSWORD}
    echo "Database created successfully"
fi 