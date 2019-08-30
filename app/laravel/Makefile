.DEFAULT_GOAL := help
APP_NAME=yz-lum
export APP_NAME

help: ## This help
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

build: down ## Build application
	@echo Build images
	@mkdir -p var/redis
	@mkdir -p var/postgres
	docker-compose build -f docker-compose.yml
	@echo

up: ## Up application
	@echo Start docker-compose
	@mkdir -p var/redis
	@mkdir -p var/postgres
	docker-compose -f docker-compose.yml up -d --force-recreate --build
	@echo

down: ## Down application
	@echo Stop docker-compose ;\
	docker-compose -f docker-compose.yml down
	@echo

nginx: ## Shell of nginx container
	docker-compose -f docker-compose.yml exec nginx /bin/sh

php-fpm: ## Shell of php-fpm container
	docker-compose -f docker-compose.yml exec php-fpm /bin/sh

postgresql: ## Shell of postgresql container
	docker-compose -f docker-compose.yml exec postgresql /bin/sh

redis: ## Shell of redis container
	docker-compose -f docker-compose.yml exec redis /bin/sh

ps: ## Status containers
	@docker-compose -f docker-compose.yml ps

log: ## Container output logs
	@docker-compose -f docker-compose.yml logs --follow

# request-logs: ## List request logs
# 	@docker-compose -f docker-compose.yml exec php-fpm ls /app/storage/logs/

default: help
