NAME = inception
COMPOSE = docker compose -f srcs/docker-compose.yml

DATA_DIRS = ${HOME}/data/mariadb_vol ${HOME}/data/wordpress_vol ${HOME}/data/portainer_vol

up:
	@echo "Creating necessary directories..."
	@mkdir -p $(DATA_DIRS)
	@echo "Starting containers..."
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
	@echo "Removing data directories..."
	@rm -rf $(DATA_DIRS)
	@osascript -e 'quit app "Docker"' && open -a Docker

ls:
	docker compose -f srcs/docker-compose.yml ps --all

re: clean up

mariadb:
	$(COMPOSE) up -d mariadb

nginx:
	$(COMPOSE) up -d nginx

wordpress:
	$(COMPOSE) up -d wordpress

redis:
	$(COMPOSE) up -d redis

portfolio:
	$(COMPOSE) up -d --build portfolio

logs:
	$(COMPOSE) logs

.PHONY: portfolio
