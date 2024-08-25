# Use the Alpine Linux 3.18 image as the base image
FROM alpine:3.18

# Check if the www-data group exists, if not, create it
RUN if ! getent group www-data > /dev/null; then addgroup -S www-data; fi

# Create the www-data user and add it to the www-data group
RUN adduser -S www-data -G www-data

# Install PHP & MariaDB client dependencies
RUN apk update && \
    apk add php81 php81-fpm php81-mysqli fcgi php81-phar wget php81-curl php81-xml php81-gd php-mbstring && \
    apk add mariadb-client

# Download and install the WP-CLI tool
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
	mv wp-cli.phar /usr/local/bin/wp

# Download and extract the WordPress package
RUN wget https://wordpress.org/wordpress-6.0.tar.gz -P /var/www/html && \
    cd /var/www/html && \
    tar -xzf /var/www/html/wordpress-6.0.tar.gz && \
    rm /var/www/html/wordpress-6.0.tar.gz

# Copy the PHP-FPM configuration file to the container
COPY conf/www.conf /etc/php81/php-fpm.d/www.conf
RUN chmod 644 /etc/php81/php-fpm.d/www.conf

# Set the working directory to the WordPress directory
WORKDIR /var/www/html/wordpress

# Copy the tools.sh script from the 'tools' directory to the container
COPY ./tools/tools.sh /usr/local/bin/tools.sh
RUN chmod +x /usr/local/bin/tools.sh

# Expose port for PHP-FPM
EXPOSE 9000

# Set the entrypoint to run the WordPress script
ENTRYPOINT ["sh", "/usr/local/bin/tools.sh"]
