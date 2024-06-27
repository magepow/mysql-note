* [Upgrade](https://mariadb.com/kb/en/upgrading)
* [Upgrade 10.2 to 10.4](https://wiki.centos-webpanel.com/mariadb-upgrade-from-10-2-to-10-4)
* [Upgrade 10.4 to 10.6](https://mariadb.com/docs/server/service-management/upgrades/community-server/release-series-cs10-6/)


## Upgrade 10.5 to 10.6 rocky linux 9

```
sudo yum remove "MariaDB-*"
sudo yum remove "mariadb-*"
sudo dnf remove "mariadb-*"
rpm --query --all | grep -i -E "mariadb|galera"
sudo systemctl enable mariadb
sudo systemctl restart mariadb
sudo mariadb-upgrade
```