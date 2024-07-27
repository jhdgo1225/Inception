FROM alpine:3.19
RUN apk add php php-fpm php-cli php-iconv php-phar php-mysqli php-pdo curl dumb-init

COPY ./tools/script.sh /
RUN chmod +x /script.sh

ENTRYPOINT [ "/usr/bin/dumb-init", "--" ]
CMD ["/script.sh"]
