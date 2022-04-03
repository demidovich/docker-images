BUILD_TAG ?= demidovich/php-rr:8.1-alpine
CONTAINER_NAME ?= dm-php8.1-rr-alpine-local

.PHONY: Rendering SPA as native HTML for indexation of search crawlers 
.DEFAULT_GOAL := help

help: ## This help
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

build: clear ## Build image
	docker build --tag="$(BUILD_TAG)" -f Dockerfile .

clear: ## Remove image and containers
	@docker rm -vf $(CONTAINER_NAME) ||:
	@docker rmi -f $(BUILD_TAG) ||:

shell: ## Container shell
	docker run --rm -ti --name $(CONTAINER_NAME) $(BUILD_TAG) /bin/sh

push: build ## Publish image
	@echo
	@docker logout
	@docker login --username=demidovich
	@docker push $(BUILD_TAG)
	@echo

default: help
