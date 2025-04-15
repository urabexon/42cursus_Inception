# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: urabex <urabex@student.42.fr>              +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/04/12 18:56:51 by hurabe            #+#    #+#              #
#    Updated: 2025/04/15 19:47:28 by urabex           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

# ベースイメージ、バージョン設定
FROM debian:bullseye

# パッケージ情報更新、nginxとopenssl(TLS証明書のため)インストール
RUN apt-get update && apt-get install -y nginx openssl && apt-get clean && rm -rf /var/lib/apt/lists/*

# コンテナ起動時に実行する初期化スクリプトコピー
COPY ./tools/init.sh /etc/nginx/init.sh
# init.shに実行権限を付与する
RUN chmod +x /etc/nginx/init.sh

# スクリプト実行
ENTRYPOINT ["/etc/nginx/init.sh"]
