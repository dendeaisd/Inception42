# Use the alpine linux 3.19 image as the base image
FROM	alpine:3.19

RUN	apk update && \ 
	apk upgrade && \ 
	apk add --no-cache nginx
EXPOSE	443
COPY requirements/tools/fvoicu.42.fr.crt /etc/ssl/certs/fvoicu.42.fr.crt
COPY requirements/tools/fvoicu.42.fr.key /etc/ssl/private/fvoicu.42.fr.key
CMD ["nginx", "-g", "daemon off;"]

