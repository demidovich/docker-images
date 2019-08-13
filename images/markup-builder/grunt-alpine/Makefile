BUILD_TAG ?= demidovich/markup-builder:alpine
CONTAINER_NAME ?= dm-mkbuilder-local

.DEFAULT_GOAL := help

help: ## This help
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

build: clear ## Build image
	docker build --tag="$(BUILD_TAG)" -f Dockerfile .

clear: ## Remove image and containers
	@docker rm -vf $(CONTAINER_NAME) ||:
	@docker rmi -f $(BUILD_TAG) ||:

shell: ## Shell login
	docker run -ti --rm $(BUILD_TAG) /bin/sh

push: ## Publish image
	@echo
	@docker login
	@docker push $(BUILD_TAG)
	@echo

node: ## Show node version
	@echo
	@docker run -t --rm $(BUILD_TAG) node -v
	@echo

gulp: ## Show grunt version
	@echo
	@docker run -t --rm $(BUILD_TAG) gulp -v
	@echo

default: help
