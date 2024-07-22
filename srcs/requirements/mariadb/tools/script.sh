openrc boot
chown -R mysql:mysql /var/lib/mysql
chown -R mysql:mysql /run/mysqld
rc-service mariadb start
rc-update add mariadb default

cd /var/lib/mysql
cat << EOF > wordpressSetting
CREATE DATABASE ${MYSQL_DATABASE_NAME};
GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE_NAME}.* TO '${MYSQL_ROOT}'@'${DOMAIN_NAME}' IDENTIFIED BY '${MYSQL_DATABASE_PASSWORD}';
DELETE FROM mysql.user WHERE User='';
DROP DATABASE IF EXISTS test;
FLUSH PRIVILEGES;
EOF

mysql -u root < wordpressSetting
rm -f wordpressSetting

rc-service mariadb restart
