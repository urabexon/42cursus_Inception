#!/bin/bash

# エラー発生時に即終了させる
set -e

# SQLファイルを動的生成(PHPで記述するとENVを使用できないため)
cat << EOF > /docker-entrypoint-initdb.d/init.sql

SELECT 'Initializing database...' AS message;

CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE} CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';
FLUSH PRIVILEGES;

SELECT 'Database initialized.' AS message;

EOF

# 生成したSQLを使って初期化しながらMariaDBを起動させる
exec mariadbd --init-file=/docker-entrypoint-initdb.d/init.sql
