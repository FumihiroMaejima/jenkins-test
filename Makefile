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

##############################
# etc
##############################
help:
	@cat Makefile
