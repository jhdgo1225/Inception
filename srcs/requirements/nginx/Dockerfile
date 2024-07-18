# Nginx Settings
FROM alpine:3.19

RUN apk update && apk add nginx openssl

# WORKDIR /
COPY ./conf/nginx.conf /etc/nginx/nginx.conf

RUN openssl genpkey -algorithm RSA -out /etc/ssl/private/selfsigned.key -pkeyopt rsa_keygen_bits:4096 \
	&& openssl req -x509 -new -nodes -key /etc/ssl/private/selfsigned.key -sha256 -days 365 -out /etc/ssl/certs/selfsigned.crt -subj "/CN=localhost"

EXPOSE 443

#PHP Settings
RUN apk add php82-fpm php82-soap php82-openssl php82-gmp php82-pdo_odbc php82-json php82-dom php82-pdo php82-zip php82-mysqli php82-sqlite3 php82-apcu php82-pdo_pgsql php82-bcmath php82-gd php82-odbc php82-pdo_mysql php82-pdo_sqlite php82-gettext php82-xmlreader php82-bz2 php82-iconv php82-pdo_dblib php82-curl php82-ctype

COPY ./tools/index.php /var/lib/nginx/html
COPY ./tools/script.sh /etc/php82/script.sh

RUN sh /etc/php82/script.sh

#WordPress Settings

COPY ./tools/entry.sh /
CMD ["sh", "/entry.sh"]
# CMD ["nginx", "-g", "daemon off;"]