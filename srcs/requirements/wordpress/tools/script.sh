sed -i "s|;listen.owner\s*=\s*nobody|listen.owner = ${PHP_FPM_USER}|g" ${PHP_FPM_CONF_FILE}
sed -i "s|;listen.group\s*=\s*nobody|listen.group = ${PHP_FPM_GROUP}|g" ${PHP_FPM_CONF_FILE}
sed -i "s|;listen.mode\s*=\s*0660|listen.mode = ${PHP_FPM_LISTEN_MODE}|g" ${PHP_FPM_CONF_FILE}
sed -i "s|user\s*=\s*nobody|user = ${PHP_FPM_USER}|g" ${PHP_FPM_CONF_FILE}
sed -i "s|group\s*=\s*nobody|group = ${PHP_FPM_GROUP}|g" ${PHP_FPM_CONF_FILE}
sed -i "s|;log_level\s*=\s*notice|log_level = notice|g" ${PHP_FPM_CONF_FILE} #uncommenting line

sed -i "s|display_errors\s*=\s*Off|display_errors = ${PHP_DISPLAY_ERRORS}|i" ${PHP_INI_FILE}
sed -i "s|display_startup_errors\s*=\s*Off|display_startup_errors = ${PHP_DISPLAY_STARTUP_ERRORS}|i" ${PHP_INI_FILE}
sed -i "s|error_reporting\s*=\s*E_ALL & ~E_DEPRECATED & ~E_STRICT|error_reporting = ${PHP_ERROR_REPORTING}|i" ${PHP_INI_FILE}
sed -i "s|;*memory_limit =.*|memory_limit = ${PHP_MEMORY_LIMIT}|i" ${PHP_INI_FILE}
sed -i "s|;*upload_max_filesize =.*|upload_max_filesize = ${PHP_MAX_UPLOAD}|i" ${PHP_INI_FILE}
sed -i "s|;*max_file_uploads =.*|max_file_uploads = ${PHP_MAX_FILE_UPLOAD}|i" ${PHP_INI_FILE}
sed -i "s|;*post_max_size =.*|post_max_size = ${PHP_MAX_POST}|i" ${PHP_INI_FILE}
sed -i "s|;*cgi.fix_pathinfo=.*|cgi.fix_pathinfo= ${PHP_CGI_FIX_PATHINFO}|i" ${PHP_INI_FILE}

if [ ! -f /usr/local/bin/wp ]; then
	curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
	chmod +x wp-cli.phar
	mv wp-cli.phar /usr/local/bin/wp
	cd ${WEBSERV_ROOT_DIRECTORY}
	rm -rf *
	wp core download --allow-root
	chown -R nginx:nginx ${WEBSERV_ROOT_DIRECTORY}
	chmod 777 ${WEBSERV_ROOT_DIRECTORY}

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
fi
