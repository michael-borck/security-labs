COMPOSE = docker compose

.PHONY: help run stop status down netmaps
help:
	@echo "  make run      Start the lab (pull images, then bring up)"
	@echo "  make stop     Stop the containers"
	@echo "  make status   Show running containers"
	@echo "  make down     Stop and remove everything (including volumes)"
	@echo "  make netmaps  Regenerate the network diagram from docker-compose.yml"

run:
	$(COMPOSE) pull || $(COMPOSE) build
	$(COMPOSE) up -d
	@echo "Lab up. Enter the attacker box:  docker compose exec attacker bash"

stop:
	$(COMPOSE) stop

status:
	$(COMPOSE) ps

down:
	$(COMPOSE) down -v

netmaps:
	python3 tools/gen-netmap.py
