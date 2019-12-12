build-all: submodule up-redis build-golang up-golang build-api up-api

submodule:
	git submodule update --init

build-golang:
	cd $(CURDIR)/golang && make

build-api:
	cd $(CURDIR)/api && make

.PHONY: redis
redis:
	docker exec -it guestbook-redis redis-cli -h localhost

up-redis:
	docker-compose up -d guestbook-redis

up-golang:
	docker-compose up -d guestbook-golang

up-api:
	docker-compose up -d guestbook-api

up:
	docker-compose up -d

down:
	docker-compose down

test:
	cd $(CURDIR)/api && make test
