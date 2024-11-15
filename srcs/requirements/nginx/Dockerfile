#the base image for the Docker container will be alpine
FROM alpine:3.16

#will run following commands and instal the nginx
RUN apk update && apk upgrade && apk add --no-cache nginx

#the container will be listening on port 443, the port the application will use for networking
EXPOSE 443

# runs "executable", "-g daemon off;" This option tells NGINX to run in the foreground
CMD [ "nginx", "-g", "daemon off;"]
