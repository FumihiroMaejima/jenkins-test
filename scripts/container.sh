#!/bin/sh

# CURRENT_DIR=$(cd $(dirname $0); pwd)
SEPARATOPION='---------------------------'
START_MESSAGE='check container status.'
DOCKER_COMPOSE_FILE='./docker-compose.yml'

# @param {string} message
showMessage() {
  echo ${SEPARATOPION}
  echo $1
}

# process start
showMessage ${START_MESSAGE}

# -qオプション container idのみを表示
# /dev/null: 出力が破棄され、なにも表示されない。
# 2(標準エラー出力) を/dev/nullに破棄することで、1(標準出力)のみを出力する。
if [[ "$(docker-compose -f ${DOCKER_COMPOSE_FILE} ps -q 2>/dev/null)" == "" ]]; then
  # コンテナが立ち上がっていない状態の時
  showMessage 'Up Docker Container!'
  docker-compose -f ${DOCKER_COMPOSE_FILE} up -d
else
  # コンテナが立ち上がっている状態の時
  showMessage 'Down Docker Container!'
  # docker-compose -f ${DOCKER_COMPOSE_FILE} down

  # jenkinsの場合、volumeを削除しないとUIが起動しなくなる。
  docker-compose -f ${DOCKER_COMPOSE_FILE} down -v
  # cacheも削除する
  rm -r src/.cache
fi

# 現在のDocker コンテナの状態を出力
showMessage 'Current Docker Status.'
docker-compose -f ${DOCKER_COMPOSE_FILE} ps

