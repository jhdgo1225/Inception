build:
	@docker-compose up -d 

rm:
	@docker-compose down

re:
	@make rm
	@make build

.PHONY: build rm re
