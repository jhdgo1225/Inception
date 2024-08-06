#!/bin/sh

sed -i 's|listen = 127.0.0.1:9000|listen = 0.0.0.0:9000|g' ${PHP_FPM_CONF_FILE}

if [ ! -f /usr/local/bin/wp ]; then
	curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
	chmod +x wp-cli.phar
	mv wp-cli.phar /usr/local/bin/wp
fi

cd $ROOT_DIRECTORY
wp core download --allow-root
rm -rf wp-config-sample.php

wp config create \
		--dbname="${WORDPRESS_DB_NAME}" \
		--dbuser="${WORDPRESS_DB_USER}" \
		--dbpass="${WORDPRESS_DB_PASSWORD}" \
		--dbhost="${WORDPRESS_DB_HOSTNAME}" \
		--locale="${LANGUAGE_CODE}" \
		--allow-root

wp core install \
		--url="${WORDPRESS_SITE_URL}" \
		--title="${WORDPRESS_SITE_NAME}" \
		--admin_user="${WORDPRESS_ADMIN_USER}" \
		--admin_password="${WORDPRESS_ADMIN_PASSWORD}" \
		--admin_email="${WORDPRESS_ADMIN_EMAIL}" \
		--skip-email \
		--allow-root

wp language core install "${LANGUAGE_CODE}" --allow-root
wp language core activate "${LANGUAGE_CODE}" --allow-root

wp user create "${WORDPRESS_NORMAL_USER}" "${WORDPRESS_NORMAL_USER_EMAIL}" --user_pass="${WORDPRESS_NORMAL_USER_PASSWORD}" --allow-root

chmod 777 $ROOT_DIRECTORY
chown -R nginx:nginx /var/lib/nginx/
exec php-fpm82 -F
