# Jenkins test

ローカルのDockerでjenkins環境を構築する為の手順書

# 構成

| 名前 | バージョン |
| :--- | :---: |
| MySQL | 8.0 |

---
# ローカル環境の構築(Mac)

## データの永続化の為にローカルに`volume`を作成する

使用イメージ: `jenkins/jenkins:latest`

`alipine-lts`なども検討したが直感的ではなかった為こちらを利用する。

`Dockerfile`使わない。

```shell-session
$ docker-compose up -d
```

container上の`/var/jenkins_home`のデータはローカルの`./src`に反映される様にしている。

`/var/jenkins_home`にsshキーを作成しておく。

```shell-session
$ docker exec -it jenkins-test-master bash

$ cd /var/jenkins_home

$ ssh-keygen -t rsa -C ""
```

## localost:8080で画面の確認

1. 起動に非常に長い時間がかかる。
2. 初期管理者パスワード後の入力後にローディングしたままの状態の時、コンテナを再起動をかけたら次の画面に進めた。(初期パスワードは入力し直し。)
3. インストールするプラグインを選択してインストール
4. 初期ユーザーの登録を行い、セットアップが完了する。

*コンテナ再起動時もやや時間がかかる。

## `volume`の確認

```shell-session
$ docker volume ls
DRIVER    VOLUME NAME
local     local-db-store
```

