# Use the Alpine Linux 3.18 image as the base image
FROM	alpine:3.18

# Install MariaDB
RUN		apk update && \
		apk add mariadb mariadb-client openrc

# Copy MariaDB configuration to the container
COPY 	./conf/my.cnf /etc/mariadb.conf.d/my.cnf
RUN		chmod 644 /etc/mariadb.conf.d/my.cnf

# Copy tools.sh script from the 'tools' directory to the container
COPY 	tools/tools.sh .
RUN 	chmod +x tools.sh

# Expose port for MariaDB
EXPOSE 	3306

# Command to set up MariaDB
ENTRYPOINT ["sh", "tools.sh"]
