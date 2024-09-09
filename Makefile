SRCS	= ./srcs
DOCKER	= sudo docker
COMPOSE	= sudo docker-compose
DATA_PATH = /home/fvoicu/data

all: build
		sudo mkdir -p $(DATA_PATH)
		sudo mkdir -p $(DATA_PATH)/wordpress
		sudo mkdir -p $(DATA_PATH)/mariadb
		sudo chmod 777 /etc/hosts
		sudo chmod 777 /home/fvoicu/data/mariadb
		sudo chmod 777 /home/fvoicu/data/wordpress

		echo "127.0.0.1 fvoicu.42.fr" | sudo tee -a /etc/hosts
		echo "127.0.0.1 www.fvoicu.42.fr" | sudo tee -a /etc/hosts
		cd $(SRCS) && $(COMPOSE) up -d

build:
		cd $(SRCS) && $(COMPOSE) build

up:
		cd $(SRCS) && $(COMPOSE) up -d

down:
		cd $(SRCS) && $(COMPOSE) down

clean:
		cd $(SRCS) && $(COMPOSE) down -v --rmi all --remove-orphans

fclean: clean
		$(DOCKER) system prune --volumes --all --force
		sudo rm -rf $(DATA_PATH)
		$(DOCKER) network prune --force
		docker volume rm $$(docker volume ls -q)
		$(DOCKER) image prune --force

re: fclean all

.PHONY: all build up down clean fclean re
