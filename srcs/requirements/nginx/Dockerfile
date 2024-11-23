# #the base image for the Docker container will be alpine
# FROM alpine:3.20

# #will run following commands and instal the nginx
# RUN apk update && apk upgrade && apk add --no-cache nginx

# #the container will be listening on port 443, the port the application will use for networking
# EXPOSE 443

# # runs "executable", "-g daemon off;" This option tells NGINX to run in the foreground
# CMD [ "nginx", "-g", "daemon off;"]

FROM debian:buster

RUN apt-get update -y && apt-get upgrade -y

RUN apt-get install -y nginx openssl && rm -rf /var/lib/apt/lists/*

COPY ./conf/default.conf /etc/nginx/sites-available/

COPY ./tools/run_nginx.sh /

WORKDIR /

EXPOSE 443

RUN chmod +x run_nginx.sh

CMD ["/run_nginx.sh"]