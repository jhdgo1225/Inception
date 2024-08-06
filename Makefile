build:
	@mkdir -p /home/jonghopa/data/wp
	@mkdir -p /home/jonghopa/data/db
	@docker-compose -f ./srcs/docker-compose.yml up -d --build

down:
	@docker-compose -f ./srcs/docker-compose.yml down

clean:
	@make down
	@docker image rm -f srcs_nginx srcs_wordpress srcs_mariadb

fclean:
	@make clean
	@docker buildx prune
	@sudo rm -rf /home/jonghopa/data/wp
	@sudo rm -rf /home/jonghopa/data/db
	@docker volume rm -f ft_db
	@docker volume rm -f ft_wp

re:
	@make clean
	@make build

.PHONY: build down clean fclean re
