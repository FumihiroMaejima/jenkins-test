.PHONY: help
.DEFAULT_GOAL := help

CMD=default
MYSQL_VERSION80=8.0
MYSQL_VERSION57=5.7

echo:
	@echo test
	@date "+%m/%d/%Y %H:%M"

##############################
# make docker environmental
##############################
up:
	docker-compose up -d

stop:
	docker-compose stop

down:
	docker-compose down

down-rmi:
	docker-compose down --rmi all
ps:
	docker-compose ps

dev:
	sh ./scripts/container.sh

##############################
# jenkins
##############################
clear-src:
	rm -rf src/* && \
	rm -r src/.cache && \
	rm -r src/.java

rebuild: # down container & remove cacahe & rebuild container.
	docker-compose down --rmi all && \
	rm -r src/.cache && \
	sh ./scripts/container.sh

quiet: # down jenkins.
	curl -X POST -H "Content-Type: application/x-www-form-urlencoded" -d '{}' localhost:8080/quietDown

##############################
# etc
##############################
help:
	@cat Makefile
