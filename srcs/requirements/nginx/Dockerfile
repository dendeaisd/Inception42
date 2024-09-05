# Use the alpine linux 3.19 image as the base image
FROM	alpine:3.19

# Update the package index, upgrade installed packages and install Nginx with no cache
# Nginx package index is not saved ==> reduces the size, ensures that the latest version is installed  
RUN	apk update && \ 
	apk upgrade && \ 
	apk add --no-cache nginx

# The container will listen on port 443 at runtime (default for HTTPS)
# Expose doesn t actually open the port, just tells Docke that the container
# should expect traffic on this port
EXPOSE	443

# Tells Docker what to run when the container starts
# Prevents nginx from running in the background, neccesary for containers
# bcs Docker expects the main process to stay in the foreground
CMD ["nginx", "-g", "daemon off;"]

