FROM debian:bullseye

RUN apt update -y \
&& apt upgrade -y \
&& apt install -y mariadb-server

COPY mariadb.cnf /etc/mysql/mariadb.cnf.d/mariadb.cnf
RUN chmod 644 /etc/mysql/mariadb.cnf.d/mariadb.cnf

COPY ./setup.sh /tmp/setup.sh
RUN chmod +x /tmp/setup.sh

ENTRYPOINT ["sh", "/tmp/setup.sh"]