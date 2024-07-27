#!/bin/sh

mkdir -p /run/mysqld
mysql_install_db --user=mysql --ldata=/var/lib/mysql
chown -R mysql:mysql /run/mysqld
chown -R mysql:mysql /var/lib/mysql
chmod 777 /var/lib/mysql

cat << EOF > /tmp/tmpFile
CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE_NAME;
GRANT ALL PRIVILEGES ON $MYSQL_DATABASE_NAME.* TO '$MYSQL_ROOT_NAME'@'localhost' IDENTIFIED BY '$MYSQL_DATABASE_PASSWORD';
GRANT ALL PRIVILEGES ON $MYSQL_DATABASE_NAME.* TO '$MYSQL_ROOT_NAME'@'%' IDENTIFIED BY '$MYSQL_DATABASE_PASSWORD';
DELETE FROM mysql.user WHERE User='';
DROP DATABASE IF EXISTS test;
FLUSH PRIVILEGES;
EOF

openrc boot

rc-update add mariadb default
rc-service mariadb start

mysql -u root < /tmp/tmpFile

rc-service mariadb stop
exec /usr/bin/mysqld_safe --user=mysql --datadir="/var/lib/mysql"
