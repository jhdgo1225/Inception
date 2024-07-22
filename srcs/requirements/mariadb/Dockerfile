FROM alpine:3.19
RUN apk add mariadb mariadb-client openrc dumb-init

COPY ./tools/script.sh /var/lib/mysql/
COPY ./conf/my.cnf /etc/my.cnf
COPY ./conf/mariadb-server.cnf /etc/my.cnf.d/
RUN mkdir -p /run/mysqld \
	&& mysql_install_db --user=mysql --ldata=/var/lib/mysql \
	&& sh /var/lib/mysql/script.sh

ENTRYPOINT [ "/usr/bin/dumb-init", "--" ]
CMD ["mariadbd-safe", "--syslog", "--datadir=/var/lib/mysql"]
