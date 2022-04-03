.DEFAULT_GOAL := help

export HOST_UID  	?= $(shell id -u)
export HOST_GID  	?= $(shell id -g)

docker_bin := $(shell command -v docker 2> /dev/null)
docker_compose_bin := $(shell command -v docker-compose 2> /dev/null)

all_images = php-rr-example

help: ## This help
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

init: ## Install composer
	$(docker_compose_bin) run --rm app composer install

up: ## Up application
	$(docker_compose_bin) up -d

down: ## Down application
	$(docker_compose_bin) down

# shell: ## Container shell
# 	$(docker_compose_bin) run --rm app /bin/sh

# shell-root: ## Container shell root
# 	$(docker_compose_bin) run --rm --user root app /bin/sh

shell-root: ## Container shell root
	$(docker_compose_bin) exec --user root app /bin/sh

clean: down ## Remove all images
	$(docker_compose_bin) rm --force --stop -v

clean-all: clean ## Remove all images
	$(foreach image,$(all_images),$(docker_bin) rmi -f $(image);)

default: help
