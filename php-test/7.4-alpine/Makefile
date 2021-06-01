BUILD_TAG ?= demidovich/php-test:7.4-alpine
APP_DIR ?= $(PWD)/test/app

.PHONY: Rendering SPA as native HTML for indexation of search crawlers 
.DEFAULT_GOAL := help

help: ## This help
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

build: clean ## Build image
	docker build --tag="$(BUILD_TAG)" -f Dockerfile .

clean: ## Remove image and containers
	@docker rmi -f $(BUILD_TAG) ||:

shell: ## Container shell
	docker run --rm -ti $(BUILD_TAG) /bin/sh

push: build ## Publish image
	@echo
	@docker logout
	@docker login --username=demidovich
	@docker push $(BUILD_TAG)
	@echo

default: help
