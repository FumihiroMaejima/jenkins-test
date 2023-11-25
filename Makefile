.PHONY: help
.DEFAULT_GOAL := help

CMD=default
MYSQL_VERSION80=8.0
MYSQL_VERSION57=5.7

SEVICE_NAME=jenkins-master

# etc
TMP_PARAM=
TMP_PARAM2=

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
	docker-compose -f ./docker-compose.manual.yml stop

manual-down:
	docker-compose -f ./docker-compose.manual.yml down -v && \
	rm -r manual/home/.cache

manual-down-rmi:
	docker-compose -f ./docker-compose.manual.yml down --rmi all

manual-ps:
	docker-compose -f ./docker-compose.manual.yml ps

manual-rebuild: # 個別のコンテナを作り直し
	docker-compose -f ./docker-compose.manual.yml build --no-cache $(SEVICE_NAME)

manual-bash-profile:
	docker-compose exec jenkins-master bash -c '/usr/local/scripts/create-bash_profile.sh'

manual-config-list:
	docker-compose exec jenkins-master bash -c '/usr/local/scripts/aws/get-aws-config-list.sh $(TMP_PARAM)'

manual-s3-list:
	docker-compose exec jenkins-master bash -c '/usr/local/scripts/aws/get-aws-s3-list.sh $(TMP_PARAM)'

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
