#!/bin/sh

cd /var/lib/nginx/html
wget https://wordpress.org/latest.tar.gz
tar -xzvf latest.tar.gz
rm latest.tar.gz
chown -R nginx:nginx wordpress

php-fpm82
nginx -g 'daemon off;'
