# Use the Alpine Linux 3.18 image as the base image
FROM	alpine:3.18

# Install NGINX and SSL
RUN		apk update && \
		apk add nginx && \
		apk add openssl

# Create directories to store the SSL certificates and the PID
RUN		mkdir -p /etc/nginx/ssl && \
		mkdir -p /run/nginx

# Add a new user within the container for security purposes
RUN		adduser -D -H -s /sbin/nologin www

# Copy NGINX configuration to the container
COPY 	conf/nginx.conf /etc/nginx/nginx.conf
RUN		chmod 644 /etc/nginx/nginx.conf

# Copy tools.sh script from the 'tools' directory to the container
COPY 	tools/tools.sh .
RUN 	chmod +x tools.sh

# Expose port for HTTPS
EXPOSE 	443

# Command to start NGINX
ENTRYPOINT ["sh", "tools.sh"]
