NAME = fwahl_inception


up:
	docker-compose -p $(NAME) -f srcs/docker-compose.yml up --build

down:
	docker-compose -p $(NAME) -f srcs/docker-compose.yml down

start:
	docker-compose -p $(NAME) -f srcs/docker-compose.yml start

stop:
	docker-compose -p $(NAME) -f srcs/docker-compose.yml stop

restart:
	$(MAKE) stop
	$(MAKE) up

clean:
	docker-compose -p $(NAME) -f srcs/docker-compose.yml down --volumes --remove-orphans
	docker system prune --force --volumes

re: clean up
