#!/bin/sh

echo "Starting WordPress setup script".

while ! mariadb -h $DB_HOST -u $DB_USER -p$DB_PASSWORD $DB_DATABASE_NAME &>/dev/null;
do
	echo "Waiting for the database to be ready";
	sleep 3;
done
	echo "Database is ready!"

echo $PWD
# Verify if the wordpress is set up
if [ -f wp-config.php ]; then
	echo "WordPress: already set up"
else
	echo "WordPress: setting up"

	# Create the wordpress configuration file
	wp config create \
		--dbname=${DB_DATABASE_NAME} \
		--dbuser=${DB_USER} \
		--dbpass=${DB_PASSWORD} \
		--dbhost=${DB_HOST} \
		--allow-root;

	# Set up WordPress with initial configuration
	wp core install \
		--url=https://${DOMAIN_NAME} \
		--title=${WP_TITLE} \
		--admin_user=${ADMIN_USER} \
		--admin_password=${ADMIN_PASSWORD} \
		--admin_email=${ADMIN_EMAIL} \
		--path=/var/www/html/wordpress/ \
		--allow-root;

	# Create an additional user with the role of author
	wp user create \
		${USER_LOGIN} \
		${USER_EMAIL} \
		--role=author \
		--user_pass=${USER_PASSWORD} \
		--allow-root \
		--path=/var/www/html/wordpress;

	# Flush the WordPress cache
	wp cache flush \
		--allow-root;

	# Install a WordPress theme
	wp theme install \
		inspiro \
		--activate \
		--allow-root;

	# Update the WordPress site URL option
	wp option update siteurl "https://jole.42.fr" \
		--allow-root;

	# Update the WordPress home option
	wp option update home "https://jole.42.fr" \
		--allow-root;


	# Display a message indicating that WordPress has been set up
	echo "WordPress: installed"

fi

# Set appropriate ownership and permissions for the WordPress directory
chown -R www-data:www-data /var/www/html
chmod -R 775 /var/www/html

# Start PHP-FPM
exec /usr/sbin/php-fpm81 -F
