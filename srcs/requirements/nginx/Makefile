build:
	@docker image build -t nginx .
	@docker container run -d -p 443:443 --name test nginx

rm:
	@docker container rm -f test
	@docker image rm -f nginx

re:
	@make rm
	@make build

.PHONY: build rm re
