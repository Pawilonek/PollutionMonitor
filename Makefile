PROJECT_NAME := DataCollector
DOCKER_COMPOSE := docker-compose -p $(PROJECT_NAME)

# Include file with environment settings
include .env

# Run by default help
.DEFAULT_GOAL := help
.PHONY: help


help: ## Diapay help for commands
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-10s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

run: ## Run containers with all modules
	@$(DOCKER_COMPOSE) up -d --remove-orphans

build: ## Build all containers
	@$(DOCKER_COMPOSE) build

stop: ## Stop all containers
	@$(DOCKER_COMPOSE) stop

logs: ## Display logs of all containers
	@$(DOCKER_COMPOSE) logs -f

list: ## List all containers
	@$(DOCKER_COMPOSE) ps

remove: ## Stop and remove containers, networks, images, and volumes
	@$(DOCKER_COMPOSE) down

influx: ## Connect to InfluxDB container and log in to database
	@$(DOCKER_COMPOSE) exec influxdb influx -database '$(INFLUXDB_DATABASE)' -username '$(INFLUXDB_USERNAME)' -password '$(INFLUXDB_PASSWORD)'

php: ## Run interactive console on panel-api container
	@$(DOCKER_COMPOSE) exec panel-api sh -c "cd /app && sh"
