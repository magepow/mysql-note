#!/bin/bash

# Define MySQL credentials (securely stored in .my.cnf, not hardcoded here)
MYSQL_CNF="/root/.my.cnf"
PREFIX="appshopify_"
BACKUP_DIR="/backup/mysql"
TIMESTAMP=$(date +"%Y%m%d%H%M%S")

# Fetch databases that match the given prefix
DATABASES=$(mysql --defaults-extra-file=$MYSQL_CNF -e "SHOW DATABASES LIKE '$PREFIX%'" | tail -n +2)

# If no databases were found, exit
if [ -z "$DATABASES" ]; then
    echo "No databases found with prefix '$PREFIX%'. Exiting."
    exit 1
fi

# Loop through each database and dump it
for DATABASE in $DATABASES; do
    #BACKUP_FILE="$BACKUP_DIR/${DATABASE}_$TIMESTAMP.sql.gz"
    BACKUP_FILE="$BACKUP_DIR/${DATABASE}.sql.gz"

    # Use mysqldump to dump the database and compress the output
    mysqldump --defaults-extra-file=$MYSQL_CNF --opt --add-drop-database --databases $DATABASE | gzip > $BACKUP_FILE

    # Check if the backup was successful
    if [ $? -eq 0 ]; then
        echo "Backup successful for database '$DATABASE'! Saved to $BACKUP_FILE"
    else
        echo "Backup failed for database '$DATABASE'."
    fi
done
