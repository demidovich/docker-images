IMAGE_NAME ?= demidovich/node:npm-slim
CONTAINER_NAME ?= node-npm-slim-local

.PHONY: Rendering SPA as native HTML for indexation of search crawlers 
.DEFAULT_GOAL := help

help: ## This help
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

build: ## Build container
	docker build --tag="$(IMAGE_NAME)" -f Dockerfile .

clean: ## Remove image and containers
	@docker rm -vf $(CONTAINER_NAME) ||:
	@docker rmi -f $(IMAGE_NAME) ||:

shell-node: ## Shell node login
	docker run -ti --rm --entrypoint /bin/bash $(IMAGE_NAME)

shell-root: ## Shell root login
	docker run --user root -ti --rm --entrypoint /bin/bash $(IMAGE_NAME)

push: build ## Publish image
	@echo
	@docker login
	@docker push $(IMAGE_NAME)
	@echo

default: help
