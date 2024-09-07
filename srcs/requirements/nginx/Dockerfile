# Use the alpine linux 3.19 image as the base image
FROM	alpine:3.19


RUN	apk update && \ 
	apk upgrade && \ 
	apk add --no-cache nginx
EXPOSE	443

CMD ["nginx", "-g", "daemon off;"]

