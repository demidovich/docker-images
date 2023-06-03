IMAGE_NAME ?= demidovich/apidoc:1.0.2
CONTAINER_NAME ?= apidoc-alpine-local

.PHONY: Rendering SPA as native HTML for indexation of search crawlers 
.DEFAULT_GOAL := help

help: ## This help
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

build: clean ## Build container
	docker build --tag="$(IMAGE_NAME)" -f Dockerfile .

clean: ## Remove image and containers
	@docker rm -vf $(CONTAINER_NAME) ||:
	@docker rmi -f $(IMAGE_NAME) ||:

shell: ## Shell login
	docker run --user root -ti --rm --entrypoint /bin/sh $(IMAGE_NAME)

push: build ## Publish image
	@echo
	@docker login
	@docker push $(IMAGE_NAME)
	@echo

default: help
