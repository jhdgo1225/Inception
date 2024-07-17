FROM alpine:3.19

RUN apk update && apk add nginx openssl

WORKDIR /var/lib/nginx
COPY ./conf/nginx.conf /etc/nginx/nginx.conf

RUN openssl genpkey -algorithm RSA -out /etc/ssl/private/selfsigned.key -pkeyopt rsa_keygen_bits:4096 \
	&& openssl req -x509 -new -nodes -key /etc/ssl/private/selfsigned.key -sha256 -days 365 -out /etc/ssl/certs/selfsigned.crt -subj "/CN=localhost"

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]
