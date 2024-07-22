FROM alpine:3.19
RUN apk add php php-fpm php-cli php-phar php-mysqli php-pdo curl dumb-init

COPY ./tools/script.sh /etc/php82/
RUN sh /etc/php82/script.sh

ENTRYPOINT [ "/usr/bin/dumb-init", "--" ]
CMD ["php-fpm82", "-F"]