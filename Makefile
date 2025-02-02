NAME = inception
COMPOSE = docker-compose --env-file secrets/.env -f srcs/docker-compose.yml

up:
	$(COMPOSE) up --build -d

down:
	$(COMPOSE) down

start:
	$(COMPOSE) start

stop:
	$(COMPOSE) stop

restart:
	$(MAKE) down
	$(MAKE) up

clean:
	$(COMPOSE) down --volumes --remove-orphans
	docker system prune --force --volumes

re: clean up

mariadb:
	$(COMPOSE) up -d mariadb

nginx:
	$(COMPOSE) up -d nginx

wordpress:
	$(COMPOSE) up -d wordpress
