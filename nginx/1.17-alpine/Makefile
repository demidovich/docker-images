BUILD_TAG ?= nginx/front
CONTAINER_NAME ?= nginx-front-local
APP_DIR ?= $(PWD)/test/app

.PHONY: Rendering SPA as native HTML for indexation of search crawlers 
.DEFAULT_GOAL := help

help: ## This help
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

build: clear ## Build container
	docker build --tag="$(BUILD_TAG)" -f Dockerfile .

clear: stop ## Remove image and containers
	@docker rm -vf $(CONTAINER_NAME) ||:
	@docker rmi -f $(BUILD_TAG) ||:

start: stop ## Start container (8080 port)
	@echo Starting container $(CONTAINER_NAME) ;\
	docker run -d --rm --name $(CONTAINER_NAME) -p 8080:80 -v $(PWD)/conf/hosts:/etc/nginx/hosts -v $(APP_DIR):/app $(BUILD_TAG)
	@docker exec -t $(CONTAINER_NAME) nginx -v

start-host: stop ## Start container (80 port, network host)
	@echo Starting container $(CONTAINER_NAME) ;\
	docker run -d --rm --name $(CONTAINER_NAME) --network host -v $(PWD)/conf/hosts:/etc/nginx/hosts -v $(PWD)/test/app:/app $(BUILD_TAG)
	@docker exec -t $(CONTAINER_NAME) nginx -v

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

test: stop ## Test container
	@docker run -d --rm --name $(CONTAINER_NAME) -p 8080:80 -v $(PWD)/conf/hosts:/etc/nginx/hosts -v $(PWD)/test/app:/app $(BUILD_TAG)
	@echo
	@docker exec -t $(CONTAINER_NAME) nginx -v
	@echo
	@docker exec -t $(CONTAINER_NAME) nginx -t
	@echo
	@test/test.sh --url=http://localhost:8080/ --contains="Nginx html"
	@echo

v: ## Show nginx version
	@docker exec -t $(CONTAINER_NAME) nginx -v

V: ## Show nginx configure options
	@docker exec -t $(CONTAINER_NAME) nginx -V

t: ## Test nginx configuration
	@docker exec -t $(CONTAINER_NAME) nginx -t

T: ## Show nginx configuration
	@docker exec -t $(CONTAINER_NAME) nginx -T

default: help
