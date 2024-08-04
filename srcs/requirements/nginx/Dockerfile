# Nginx Settings
FROM alpine:3.19

RUN apk update && apk add nginx openssl && apk add dumb-init

RUN openssl genpkey -algorithm RSA -out /etc/ssl/private/selfsigned.key -pkeyopt rsa_keygen_bits:4096 \
	&& openssl req -x509 -new -nodes -key /etc/ssl/private/selfsigned.key -sha256 -days 365 -out /etc/ssl/certs/selfsigned.crt -subj "/CN=jonghopa.42.fr" \
	&& chown -R nginx:nginx "/var/lib/nginx/html"

COPY ./conf/nginx.conf "/etc/nginx/nginx.conf"

ENTRYPOINT [ "/usr/bin/dumb-init", "--" ]
CMD ["nginx", "-g", "daemon off;"]
