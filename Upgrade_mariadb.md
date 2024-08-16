* [Upgrade](https://mariadb.com/kb/en/upgrading)
* [Upgrade 10.2 to 10.4](https://wiki.centos-webpanel.com/mariadb-upgrade-from-10-2-to-10-4)
* [Upgrade 10.4 to 10.6](https://mariadb.com/docs/server/service-management/upgrades/community-server/release-series-cs10-6/)


## Upgrade 10.5 to 10.6 rocky linux 9

```
#Upgrade  MariaDB 10.5 to MariaDB 10.6

## Uninstall MariaDB 10.5
sudo yum remove "MariaDB-*"
sudo yum remove "mariadb-*"
sudo dnf remove "mariadb-*"
rpm --query --all | grep -i -E "mariadb|galera"

## Install MariaDB 10.6

sudo yum install wget

wget https://r.mariadb.com/downloads/mariadb_repo_setup

echo "6083ef1974d11f49d42ae668fb9d513f7dc2c6276ffa47caed488c4b47268593 mariadb_repo_setup" \
    | sha256sum -c -

chmod +x mariadb_repo_setup

sudo ./mariadb_repo_setup \
   --mariadb-server-version="mariadb-10.6"

sudo yum install MariaDB-server MariaDB-backup

sudo systemctl enable mariadb

sudo systemctl restart mariadb

## Upgrade database

sudo mariadb-upgrade
```
