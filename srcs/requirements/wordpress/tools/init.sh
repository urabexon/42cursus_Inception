# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    init.sh                                            :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: urabex <urabex@student.42.fr>              +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/04/12 18:56:29 by hurabe            #+#    #+#              #
#    Updated: 2025/04/15 18:35:06 by urabex           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#!/bin/bash

# エラー発生時に即終了させる
set -e

# MariaDBコンテナが起動完了するまで待機させる
while ! mysqladmin ping -h "$WORDPRESS_DB_HOST" --silent; do
    sleep 2
done

# wp-config.phpがまだ存在しない場合のみ初期設定を行う
if [ ! -f /var/www/html/wp-config.php ]; then

    # WordPress作業ディレクトリに移動
    cd /var/www/html
    
    # WordPressをダウンロード
    wp core download --path=/var/www/html --locale=ja --allow-root
    
    # wp-config.phpを環境変数に基づいて自動生成する
    wp config create \
        --dbname="$MYSQL_DATABASE" \
        --dbuser="$MYSQL_USER" \
        --dbpass="$MYSQL_PASSWORD" \
        --dbhost="$WORDPRESS_DB_HOST" \
        --allow-root \
        --skip-check

    # サイト情報と管理者ユーザーを自動設定する
    wp core install \
        --url="$DOMAIN" \
        --title="$WORDPRESS_SITE_TITLE" \
        --admin_user="$WORDPRESS_ADMIN_USER" \
        --admin_password="$WORDPRESS_ADMIN_PASSWORD" \
        --admin_email="$WORDPRESS_ADMIN_EMAIL" \
        --skip-email \
        --allow-root

    # 編集者ロールの一般ユーザーを追加する
    wp user create \
        "${WORDPRESS_EDITOR_USER}" \
        "${WORDPRESS_EDITOR_EMAIL}" \
        --user_pass="${WORDPRESS_EDITOR_PASSWORD}" \
        --role=editor \
        --allow-root

    # ここで一応所有権をwww-dataに再設定しておく(NginxやPHP-FPMの実行ユーザーのため)
    chown -R www-data:www-data /var/www/html
fi

# PHP-FPMを実行する(フォアグラウンド)
exec php-fpm7.4 -F
