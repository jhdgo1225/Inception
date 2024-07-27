build:
	@docker-compose -f ./srcs/docker-compose.yml up --build -d

rm:
	@docker-compose -f ./srcs/docker-compose.yml down

re:
	@make rm
	@make build

.PHONY: build rm re
