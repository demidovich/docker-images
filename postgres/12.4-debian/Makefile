BUILD_TAG ?= demidovich/postgres:12.4-debian
CONTAINER_NAME ?= dm-postgres-debian-local

.PHONY: Rendering SPA as native HTML for indexation of search crawlers 
.DEFAULT_GOAL := help

help: ## This help
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

build: clear ## Build image
	docker build --tag="$(BUILD_TAG)" -f Dockerfile .

clear: stop ## Remove image and containers
	@docker rm -vf $(CONTAINER_NAME) ||:
	@docker rmi -f $(BUILD_TAG) ||:

start: stop ## Start container (15432)
	@echo Starting container $(CONTAINER_NAME) ;\
	docker run --rm --name $(CONTAINER_NAME) -e POSTGRES_PASSWORD=postgres -d $(BUILD_TAG)
	@docker exec -t $(CONTAINER_NAME) psql -V

status: ## Container status
	@if [ $(shell docker ps -a --no-trunc --quiet --filter name=^$(CONTAINER_NAME)$$ | wc -l) -eq 1 ]; then \
		echo Running ;\
	fi
	@if [ $(shell docker ps -a --no-trunc --quiet --filter name=^$(CONTAINER_NAME)$$ | wc -l) -eq 0 ]; then \
		echo Not running ;\
	fi

stop: ## Stop container
	@if [ $(shell docker ps -a --no-trunc --quiet --filter name=^$(CONTAINER_NAME)$$ | wc -l) -eq 1 ]; then \
		echo Stopping container $(CONTAINER_NAME) ;\
		docker stop $(CONTAINER_NAME) > /dev/null ;\
	fi

shell: ## Shell login
	docker exec --user root -ti $(CONTAINER_NAME) /bin/bash

psql: ## Shell login
	docker exec --user postgres -ti $(CONTAINER_NAME) psql

pg_activity: ## PG activity monitor
	docker exec --user postgres -ti $(CONTAINER_NAME) pg_activity

push: build ## Publish image
	@echo
	@docker logout
	@docker login --username=demidovich
	@docker push $(BUILD_TAG)
	@echo

test: ## Test container
	@echo
	@docker exec -t $(CONTAINER_NAME) psql -V
	@echo
	@docker exec -t $(CONTAINER_NAME) psql -U postgres -c "SELECT CURRENT_DATE AS select_date"
	@echo

v: ## Show Postgresql version
	@docker exec -t $(CONTAINER_NAME) psql -V

c: ## Show Postgresql settings
	@echo
	@docker exec -t $(CONTAINER_NAME) psql -U postgres -x -P pager=off -c "SELECT * FROM pg_settings"
	@echo

default: help
