# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: hurabe <hurabe@student.42.fr>              +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/04/12 18:09:20 by hurabe            #+#    #+#              #
#    Updated: 2025/04/12 18:57:42 by hurabe           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

all: up

prepare:
	mkdir -p $(HOME)/data/db_data $(HOME)/data/wp_data $(HOME)/data/ssl_certs

build:
	cd srcs && docker compose build

up: prepare build
	cd srcs && docker compose up -d

down:
	cd srcs && docker compose down

stop:
	cd srcs && docker compose stop

clean:
	cd srcs && docker compose down -v --rmi all --remove-orphans

fclean: clean
	sudo rm -rf $(HOME)/data/

re: fclean up

.PHONY: all prepare build up down stop clean fclean re
