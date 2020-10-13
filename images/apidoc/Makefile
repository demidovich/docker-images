BUILD_TAG ?= demidovich/apidoc:alpine
CONTAINER_NAME ?= apidoc-alpine-local

.PHONY: Rendering SPA as native HTML for indexation of search crawlers 
.DEFAULT_GOAL := help

help: ## This help
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

build: clear ## Build container
	docker build --tag="$(BUILD_TAG)" -f Dockerfile .

clear: ## Remove image and containers
	@docker rm -vf $(CONTAINER_NAME) ||:
	@docker rmi -f $(BUILD_TAG) ||:

shell: ## Shell login
	docker exec -ti $(CONTAINER_NAME) /bin/sh

push: build ## Publish image
	@echo
	@docker login
	@docker push $(BUILD_TAG)
	@echo

default: help
