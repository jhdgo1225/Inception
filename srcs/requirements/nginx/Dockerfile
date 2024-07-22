# Nginx Settings
FROM alpine:3.19

RUN apk update && apk add nginx openssl && apk add dumb-init

COPY ./conf/nginx.conf /etc/nginx/nginx.conf

RUN openssl genpkey -algorithm RSA -out ${SSL_PRIVATE_KEY} -pkeyopt rsa_keygen_bits:4096 \
	&& openssl req -x509 -new -nodes -key ${SSL_PRIVATE_KEY} -sha256 -days 365 -out ${SSL_CERT} -subj "/CN=${DOMAIN_NAME}"

ENTRYPOINT [ "/usr/bin/dumb-init", "--" ]
CMD ["nginx", "-g", "daemon off;"]