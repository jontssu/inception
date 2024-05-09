#!/bin/sh
if [! -d "/var/www/wordpress/wp-admin"]; then
	sleep 10
	wp core download --allow-root
	wp config create --allow-root \
	--dbname=$DATABASE \
	--dbuser=$MYSQL_USER \
	--dbpass=$MYSQL_PASSWORD \
	--dbhost=mariadb:3306

	wp core install --allow-root \
		--title=myTitle \
		--admin_user=$WP_ADMIN \
		--admin_password=$WP_ADMIN_PASS  \
		--admin_email=$WP_ADMIN_EMAIL \
		--skip-email \
		--url='jole.42.fr'


	wp user create --allow-root \
		$WP_USER \
		$WP_USER_EMAIL \
		--user_pass=$WP_USER_PASS

fi

if [ ! -d "/run/php" ]; then
	mkdir -p "/run/php"
fi

/usr/bin/php-fpm8.1 -F