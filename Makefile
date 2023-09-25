include mongo.properties

ENV_FILES = --env-file mongo.properties $(if $(wildcard .env), --env-file .env)

.PHONY: stop
stop:
	docker compose -p $(MONGO_APP_NAME) down

.PHONY: start
start: stop
	docker compose --project-directory . -p $(MONGO_APP_NAME) $(ENV_FILES) -f docker-compose.mongo.yml up --build $(ARGS)

.PHONY: clean_dangling_volumes
clean_dangling_volumes: stop
	docker volume ls -qf dangling=true | egrep '^[a-z0-9]{64}' | xargs docker volume rm

.PHONY: clean
clean: clean_dangling_volumes
#	docker compose -p $(MONGO_APP_NAME) ps -aq | xargs docker rm -f
#	docker network ls --filter "name=$(MONGO_APP_NAME).*" -q | xargs docker network rm
	docker images -q --filter "label=com.docker.compose.project=$(MONGO_APP_NAME)" | xargs docker rmi -f

.PHONY: clean_db
clean_db: clean_dangling_volumes
	docker volume ls -q --filter "label=com.docker.compose.project=$(MONGO_APP_NAME)" | xargs docker volume rm

### ----------------------------------------------------------------------- ###
###  Caution: Use the following commands carefully!                         ###
###  This warning emphasizes the need for caution when using the commands.  ###
### ----------------------------------------------------------------------- ###

.PHONY: prune
prune: stop
	docker system prune

.PHONY: prune_with_volumes
prune_with_volumes: stop
	docker system prune -a --volumes
