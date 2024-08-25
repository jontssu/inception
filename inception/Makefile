include srcs/.env
export $(sed 's/=.*//' srcs/.env)

all: up

up: setup
	docker compose -f srcs/docker-compose.yml up -d

build: setup
	docker compose -f srcs/docker-compose.yml build

down:
	docker compose -f srcs/docker-compose.yml down

start:
	docker compose -f srcs/docker-compose.yml start

stop:
	docker compose -f srcs/docker-compose.yml stop

status:
	cd srcs && docker compose ps && cd ..

logs:
	cd srcs && docker compose logs && cd ..

setup: ${WORDPRESS_VOLUME} ${MARIADB_VOLUME}
	@if ! sudo grep -q "127.0.0.1 ${DOMAIN_NAME}" /etc/hosts; then \
    	echo "127.0.0.1 ${DOMAIN_NAME}" | sudo tee -a /etc/hosts; \
	fi

${WORDPRESS_VOLUME}:
	mkdir -p ${WORDPRESS_VOLUME}

${MARIADB_VOLUME}:
	mkdir -p ${MARIADB_VOLUME}

clean:
	sudo rm -rf ${DATA_PATH}

fclean: down clean
	# docker-compose -f srcs/docker-compose.yml down --volumes --rmi all
	docker system prune -f -a --volumes --all

re: down fclean up

.PHONY: all up down stop start logs status clean fclean re setup build
