


.PHONY: help
help: ## Show this help
	@egrep -h '\s##\s' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'


check:  ## Confirm we have docker
	@echo "TODO: Quick setup to ensure docker and docker-compose are installed"
	docker --version
	docker-compose --version

stop:  ## Start
	docker-compose stop 

start: ## Start 
	docker-compose up -d 

destroy:  ## Destroy the resources
	@echo "Destroying"
	docker-compose down

refresh: destroy start ## Recreate the resources removing state

restart: stop start ## Restart the server keeping state

prod-mode:  ## Enable production to run in a prod server with separate DB
	@echo "Running in production mode"
	mv docker-compose.yaml docker-compose.dev.yaml
	mv docker-compose.prod.yaml docker-compose.yaml

dev-mode:  ## Enabled dev mode to run in a development machine
	@echo "Running in dev mode"
	mv docker-compose.yaml docker-compose.dev.yaml
	mv docker-compose.prod.yaml docker-compose.yaml


serve: check prod-mode start

configure:  ## TODO: Add a step to configure the domain
	@echo "Configure your doomain name and email"
	sed -i "s/<DOMAIN_NAME>/${DOMAIN_NAME}/g" /root/docker-compose.yaml
	sed -i "s/<DOMAIN_NAME>/${DOMAIN_NAME}/g" /root/traefik.toml
	sed -i "s/<EMAIL>/${EMAIL}/g" /root/traefik.toml