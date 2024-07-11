FROM alpine:3.19

# Nginx 설치 및 기본 설정
RUN apk update && apk add nginx

# 작업 디렉토리 설정
WORKDIR /var/lib/nginx/html
COPY ./conf/nginx.conf /etc/nginx/nginx.conf

# 포트 노출
EXPOSE 80

# Nginx 시작
CMD ["nginx", "-g", "daemon off;"]
