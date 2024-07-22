build:
	@docker-compose -f ./srcs/docker-compose.yml up -d

rm:
	@docker-compose -f ./srcs/docker-compose.yml stop

re:
	@make rm
	@make build

.PHONY: build rm re
