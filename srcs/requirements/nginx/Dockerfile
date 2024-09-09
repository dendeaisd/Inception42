FROM	alpine:3.19

RUN	apk update && \ 
	apk upgrade && \ 
	apk add --no-cache nginx openssl

RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/ssl/private/fvoicu.42.fr.key \
    -out /etc/ssl/certs/fvoicu.42.fr.crt \
    -subj "/C=DE/ST=BW/L=HN/O=42 Heilbronn/OU=student/CN=fvoicu.42.fr"

EXPOSE	443

CMD ["nginx", "-g", "daemon off;"]

