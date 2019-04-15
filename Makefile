PROJECT_NAME := DataCollector
DOCKER_COMPOSE := docker-compose -p $(PROJECT_NAME)

# Include file with environment settings
include .env
# export

# Define color consts
COLOR_RESET=$(shell echo -e "\u001b[0m")

COLOR_BLACK=$(shell echo -e "\u001b[30m")
COLOR_RED=$(shell echo -e "\u001b[31m")
COLOR_GREEN=$(shell echo -e "\u001b[32m")
COLOR_YELLOW=$(shell echo -e "\u001b[33m")
COLOR_BLUE=$(shell echo -e "\u001b[34m")
COLOR_MAGENTS=$(shell echo -e "\u001b[35m")
COLOR_CYAN=$(shell echo -e "\u001b[36m")
COLOR_WHITE=$(shell echo -e "\u001b[37m")

COLOR_BLACK_BRIGHT=$(shell echo -e "\u001b[30;1m")
COLOR_RED_BRIGHT=$(shell echo -e "\u001b[31;1m")
COLOR_GREEN_BRIGHT=$(shell echo -e "\u001b[32;1m")
COLOR_YELLOW_BRIGHT=$(shell echo -e "\u001b[33;1m")
COLOR_BLUE_BRIGHT=$(shell echo -e "\u001b[34;1m")
COLOR_MAGENTS_BRIGHT=$(shell echo -e "\u001b[35;1m")
COLOR_CYAN_BRIGHT=$(shell echo -e "\u001b[36;1m")
COLOR_WHITE_BRIGHT=$(shell echo -e "\u001b[37;1m")

COLOR_BACKGROUND_BLACK=$(shell echo -e "\u001b[40m")
COLOR_BACKGROUND_RED=$(shell echo -e "\u001b[41m")
COLOR_BACKGROUND_GREEN=$(shell echo -e "\u001b[42m")
COLOR_BACKGROUND_YELLOW=$(shell echo -e "\u001b[43m")
COLOR_BACKGROUND_BLUE=$(shell echo -e "\u001b[44m")
COLOR_BACKGROUND_MAGENTS=$(shell echo -e "\u001b[45m")
COLOR_BACKGROUND_CYAN=$(shell echo -e "\u001b[46m")
COLOR_BACKGROUND_WHITE=$(shell echo -e "\u001b[47m")

COLOR_BACKGROUND_BLACK_BRIGHT=$(shell echo -e "\u001b[40;1m")
COLOR_BACKGROUND_RED_BRIGHT=$(shell echo -e "\u001b[41;1m")
COLOR_BACKGROUND_GREEN_BRIGHT=$(shell echo -e "\u001b[42;1m")
COLOR_BACKGROUND_YELLOW_BRIGHT=$(shell echo -e "\u001b[43;1m")
COLOR_BACKGROUND_BLUE_BRIGHT=$(shell echo -e "\u001b[44;1m")
COLOR_BACKGROUND_MAGENTS_BRIGHT=$(shell echo -e "\u001b[45;1m")
COLOR_BACKGROUND_CYAN_BRIGHT=$(shell echo -e "\u001b[46;1m")
COLOR_BACKGROUND_WHITE_BRIGHT=$(shell echo -e "\u001b[47;1m")

default: run

first-run:
	set GOPATH=%cd%
	go get github.com/influxdata/influxdb1-client/v2

run:
#	docker run --name wol -d -p 80:80 -v "${CURDIR}":/go --workdir /go --net=host pawilonek/wol ./main
	# docker run --name wol -d -p 80:80 -v "${CURDIR}":/go --workdir /go --net=host pawilonek/wol go run src/main/main.go
	$(DOCKER_COMPOSE) up -d
	# -d --remove-orphans

build:
	$(DOCKER_COMPOSE) build

docker-log:
	$(DOCKER_COMPOSE) logs

console:
	# $(DOCKER_COMPOSE) exec app sh
	$(DOCKER_COMPOSE) run app sh

stop:
	$(DOCKER_COMPOSE) stop

logs:
	$(DOCKER_COMPOSE) logs -f

list:
	$(DOCKER_COMPOSE) ps

remove:
	@echo -e "$(COLOR_CYAN_BRIGHT)  <[ Remove docker containers ]>  $(COLOR_RESET)"
	@echo -e "$(COLOR_BLUE_BRIGHT)Stop and remove containers, networks, images, and volumes$(COLOR_RESET)"
	@$(DOCKER_COMPOSE) down

influxdb:
	@echo -e "$(COLOR_CYAN_BRIGHT)  <[ Run InfluxDB console ]>  $(COLOR_RESET)"
	@echo -e "$(COLOR_BLUE_BRIGHT)Connect to InfluxDB container and log in to database$(COLOR_RESET)"
	@$(DOCKER_COMPOSE) exec influxdb influx -database '$(INFLUXDB_DATABASE)' -username '$(INFLUXDB_USERNAME)' -password '$(INFLUXDB_PASSWORD)'
