#!/bin/bash
# IMPORT FILES MYSQL DATABASES

MYSQL_CNF="/root/.my.cnf"
BACKUP_DIR="/backup/mysql"

find $BACKUP_DIR -type f -name "*.sql.gz" | sort --version-sort --ignore-case | while read file; 

do (
        fileName=`basename "$file"`
        dbname=${fileName//.sql.gz/}
        dbname=${dbname//.sql/}
        echo $fileName;
        echo $dbname;
        gunzip $fileName
); 
done

find $BACKUP_DIR -type f -name "*.sql" | sort --version-sort --ignore-case | while read file; 

do (
        fileName=`basename "$file"`
        dbname=${fileName//.sql.gz/}
        dbname=${dbname//.sql/}
        echo $fileName;
        echo $dbname;
        # gunzip $fileName
        mysql --defaults-extra-file=$MYSQL_CNF -e "CREATE DATABASE IF NOT EXISTS $dbname"
        mysql --defaults-extra-file=$MYSQL_CNF $dbname < $fileName
); 
done


