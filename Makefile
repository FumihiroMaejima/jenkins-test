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
# make manual docker environmental
##############################
manual-up:
	docker-compose -f ./docker-compose.manual.yml up -d && \
	echo 'jenkis-client : http://localhost:8080'

manual-stop:
	docker-compose ./docker-compose.manual.yml stop

manual-down:
	docker-compose ./docker-compose.manual.yml down -v && \
	rm -r manual/home/.cache

manual-down-rmi:
	docker-compose ./docker-compose.manual.yml down --rmi all

manual-ps:
	docker-compose ./docker-compose.manual.yml ps

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
