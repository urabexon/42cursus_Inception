# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    init.sh                                            :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: urabex <urabex@student.42.fr>              +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/04/12 18:56:26 by hurabe            #+#    #+#              #
#    Updated: 2025/04/15 14:53:31 by urabex           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#!/bin/bash

# エラー発生時に即終了させる
set -e

# SSL証明書の保存先移動
cd /etc/nginx/ssl

# 秘密鍵作成(NISTなどのセキュリティ機関が2048bit以上を推奨しており、パフォーマンスバランスがいいためこちらを指定)
openssl genrsa -out inception.key 2048

# CSR(証明書署名要求)作成
openssl req -new -key inception.key -out inception.csr -subj "/C=JP/ST=Tokyo/L=Shinjuku/O=42Tokyo/CN=hurabe.42.fr"

# CSRから自己署名証明書を作成
openssl x509 -req -days 365 -in inception.csr -signkey inception.key -out inception.crt

# Nginx実行
exec nginx -g 'daemon off;'
