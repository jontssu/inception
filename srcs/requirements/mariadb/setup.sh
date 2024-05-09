mysql -u $SQLUSER -p $SQLPASSWORD

mkdir -p /run/mysqld
chown mysql /run/mysqld
chown mysql /var/lib/mysql

if [ -d "/var/lib/mysql/$DATABASE" ]; then
	echo "Not creating Database"
else
	mysql_install_db --basedir=/usr --datadir=/var/lib/mysql --user=mysql --rpm > /dev/null

	mysql -u mysql --bootstrap << DONE
	use mysql;
	FLUSH PRIVILIGES;
	USER ALTER 'root'@'localhost' IDENTIFIED BY $MYSQL_ROOT_PASSWORD;
	USER CREATE '$MYSQL_USER'@'%' IDENTIFIED BY $MYSQL_PASSWORD;
	CREATE DATABASE IF NOT EXIST $DATABASE;
	GRANT ALL PRIVILIGES ON *.* TO '$MYSQL_USER'@'%' IDENTIFIED BY $MYSQL_PASSWORD;
	GRANT ALL PRIVILIGES ON *.* TO 'root'@'localhost' IDENTIFIED BY $MYSQL_ROOT_PASSWORD;
	GRANT SELECT ON mysql.* TO '$MYSQL_USER'@'%';
	FLUSH PRIVILIGES;
	DONE
fi

exec mysqld --defaults-file=/etc/mysql/mariadb.conf.d/mariadb.cnf