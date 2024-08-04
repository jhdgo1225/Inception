build:
	@docker-compose -f ./srcs/docker-compose.yml up -d

clean:
	@docker-compose -f ./srcs/docker-compose.yml down

fclean:
	@make clean
	@docker image rm -f srcs-nginx srcs-wordpress srcs-mariadb

re:
	@make fclean
	@make build

.PHONY: build clean fclean re
