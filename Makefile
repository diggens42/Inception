NAME = inception
COMPOSE = docker compose -f srcs/docker-compose.yml

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
	docker system prune -af --volumes

fclean: clean
	rm -rf srcs/data

re: clean up

mariadb:
	$(COMPOSE) up -d mariadb

nginx:
	$(COMPOSE) up -d nginx

wordpress:
	$(COMPOSE) up -d wordpress

redis:
	$(COMPOSE) up -d redis

logs:
	$(COMPOSE) logs
