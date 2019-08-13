include .env

VERSION ?= latest
REGISTRY ?= not_set
REGISTRY_PROJECT ?= not_set
CONTAINER_NAME ?= postgres
CONTAINER_INSTANCE ?= local

.PHONY: Database docker container for testing and development.
.DEFAULT_GOAL := help

help: ## This help
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

dump: ## Get latest database dump. make SOURCE_SCP=user@server:/file.sql build
	./script/pull-dump

build: dump clear ## Build container
	docker build --rm -t $(REGISTRY_PROJECT):$(VERSION) -f Dockerfile .
	docker run -d --name $(CONTAINER_NAME)-$(CONTAINER_INSTANCE) $(PORTS) $(VOLUMES) $(ENV) $(REGISTRY_PROJECT):$(VERSION)
	sleep 5
	docker stop $(CONTAINER_NAME)-$(CONTAINER_INSTANCE)
	#sleep 5
	#docker exec -i $(CONTAINER_NAME)-$(CONTAINER_INSTANCE) psql -U postgres postgres < ./init.sql/01_dump.sql
	#docker exec -i $(CONTAINER_NAME)-$(CONTAINER_INSTANCE) psql -U postgres postgres < ./init.sql/02_cleaner.sql
	#docker commit $(CONTAINER_NAME)-$(CONTAINER_INSTANCE) $(REGISTRY_PROJECT):$(VERSION)
	#docker stop $(CONTAINER_NAME)-$(CONTAINER_INSTANCE)

#shell: ## Shell login
#	docker run --rm -it $(PORTS) $(VOLUMES) $(ENV) $(REGISTRY_PROJECT):$(VERSION) /bin/bash

shell: ## Postgresql shell login
	docker exec -it $(CONTAINER_NAME)-$(CONTAINER_INSTANCE) /bin/bash

psql: ## Postgresql shell login
	docker exec -it $(CONTAINER_NAME)-$(CONTAINER_INSTANCE) psql -U postgres postgres

start: stop ## Start container
	docker start $(CONTAINER_NAME)-$(CONTAINER_INSTANCE)

stop: ## Stop container
	docker stop $(CONTAINER_NAME)-$(CONTAINER_INSTANCE)

clear: ## Remove image and containers
	@docker rm -vf $(CONTAINER_NAME)-$(CONTAINER_INSTANCE) ||:
	@docker rmi -f $(REGISTRY_PROJECT) ||:

rmi: stop ## Remove image
	@docker rmi -f $(REGISTRY_PROJECT) ||:

rm: stop ## Remove container
	@docker rm -vf $(CONTAINER_NAME)-$(CONTAINER_INSTANCE) ||:

release: build ## Publish container to registry
	docker tag $(REGISTRY_PROJECT) $(REGISTRY)/$(REGISTRY_PROJECT):$(VERSION)
	docker push $(REGISTRY)/$(REGISTRY_PROJECT):$(VERSION)

default: help
