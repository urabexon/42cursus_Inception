# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: urabex <urabex@student.42.fr>              +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/04/12 18:56:31 by hurabe            #+#    #+#              #
#    Updated: 2025/04/15 16:18:07 by urabex           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

# ベースイメージ、バージョン設定
FROM debian:bullseye

# パッケージ情報更新、MariaDBインストール
RUN apt-get update && apt-get install -y mariadb-server && rm -rf /var/lib/apt/lists/*
# 必要なディレクトリ作成、権限設定
RUN mkdir -p /var/run/mysqld
RUN chown -R mysql:mysql /var/run/mysqld

# MariaDB用設定ファイルと初期化スクリプトコピー
COPY ./conf/my.cnf /etc/mysql/my.cnf
COPY ./tools/init.sh /docker-entrypoint-initdb.d/init.sh

# スクリプト実行
ENTRYPOINT ["/docker-entrypoint-initdb.d/init.sh"]
