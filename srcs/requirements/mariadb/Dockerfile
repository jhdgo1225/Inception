FROM alpine:3.19

RUN apk add mysql mysql-client openrc dumb-init
COPY ./conf/my.cnf /etc/my.cnf
COPY ./conf/mariadb-server.cnf /etc/my.cnf.d/

COPY ./tools/script.sh /script.sh
RUN chmod +x /script.sh

ENTRYPOINT [ "/usr/bin/dumb-init", "--"]
CMD ["/script.sh"]
