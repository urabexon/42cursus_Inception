# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: urabex <urabex@student.42.fr>              +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/04/12 18:57:06 by hurabe            #+#    #+#              #
#    Updated: 2025/04/15 20:18:57 by urabex           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

# ベースイメージ、バージョン設定
FROM debian:bullseye

# PHP,MariaDB client, curlインストール
RUN apt-get update && apt-get install -y php7.4 php7.4-fpm php7.4-cli php7.4-mysql mariadb-client curl && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# 必要な配置先ディレクトリ作成
RUN mkdir -p /var/www/html && chown -R www-data:www-data /var/www/html

# WP-CLIインストール、権限設定
RUN curl -o /usr/local/bin/wp https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x /usr/local/bin/wp && chown root:root /usr/local/bin/wp

# PHP-FPM設定を上書きする
COPY ./conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf

# /run/php がないと PHP-FPM が起動できないため、事前に作成
RUN mkdir -p /run/php

# 起動スクリプトを追加する
COPY ./tools/init.sh /docker-entrypoint.d/init.sh
RUN chmod +x /docker-entrypoint.d/init.sh

# スクリプト実行
ENTRYPOINT ["/docker-entrypoint.d/init.sh"]
