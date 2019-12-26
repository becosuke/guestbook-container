all: submodule build up

submodule:
	git submodule update --init

build-golang:
	cd $(CURDIR)/golang && make

build-api: up-golang
	cd $(CURDIR)/guestbook-api && make

build: build-golang build-api

up-redis:
	docker-compose up -d guestbook-redis

up-node:
	docker-compose up -d guestbook-node

up-golang:
	docker-compose up -d guestbook-golang

up-api:
	docker-compose up -d guestbook-api

up:
	docker-compose up -d

down:
	docker-compose down

.PHONY: redis
redis:
	docker exec -it guestbook-redis redis-cli -h localhost

.PHONY: node
node:
	docker exec -it guestbook-node /bin/sh

test: test-guestbook-api

test-guestbook-api:
	cd $(CURDIR)/guestbook-api && make test
