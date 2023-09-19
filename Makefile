include mongo.properties

ENV_FILES=\
	--env-file mongo.properties \
	--env-file .env
COMPOSE_FILE=-f docker-compose.mongo.yml

.PHONY: stop
stop:
	docker-compose -p $(MONGO_APP_NAME) down

.PHONY: run
run: stop
	docker-compose -p $(MONGO_APP_NAME) $(ENV_FILES) $(COMPOSE_FILE) up --build $(ARGS)

.PHONY: clean
clean: stop
	docker-compose -p $(MONGO_APP_NAME) ps -aq | xargs docker rm -f
	docker images -a | awk '/$(MONGO_APP_NAME)/ { print $$3 }' | xargs docker rmi -f
	docker volume ls --quiet --filter "dangling=true" | xargs -I {} docker volume inspect {} --format '{{ .Name }}' | grep -v '\.db' | xargs -r docker volume rm

.PHONY: clean_data
clean_db: stop
	docker volume ls --quiet --filter "dangling=true" | xargs -I {} docker volume inspect {} --format '{{ .Name }}' | grep -v '\.db' | xargs -r docker volume rm
	docker volume ls --quiet | grep "^$(MONGO_APP_NAME).*\.db" | xargs -I {} docker volume rm {}

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
