BUILD_TAG ?= demidovich/postgres:11.5-alpine
CONTAINER_NAME ?= dm-postgres-alpine-local

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
	docker run -d --rm --name $(CONTAINER_NAME) -p 15432:5432 $(BUILD_TAG)
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
	docker exec -ti $(CONTAINER_NAME) /bin/sh

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
