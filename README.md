# Dockerized MongoDB Replicas

This project provides Docker configurations for creating MongoDB replicas.

## Contents

- [Running with Docker](#running-with-docker)
  - [Start Docker Containers](#start-docker-containers)
  - [Stop Docker Containers](#stop-docker-containers)
  - [Clean Up Docker Resources](#clean-up-docker-resources)
  - [Clean Up the DB](#clean-up-the-db)
- [Using it with another project](#using-it-with-another-project)

## Running with Docker

If you wish to initialize specific databases during startup, you can create a **.env** file and set the **MONGO_INITDB_DATABASE** environment variable in that file. Here's an example of how to do it:

```bash
MONGO_INITDB_DATABASE=DB1,DB2,DB3 # Databases initialized during MongoDB startup
```

### Start Docker Containers

To start Docker containers for the application, use the following command:

```bash
make start ARGS=-d # Run the containers in background
```

This command also stops any existing containers related to this application before starting new ones.

### Stop Docker Containers

To stop all Docker containers related to this application, use the following command:

```bash
make stop
```

### Clean Up Docker Resources

To clean up Docker resources, including removing containers, images, and volumes, use the following command:

```bash
make clean
```

This command will:

- Stop any existing containers related to the application and remove them
- Remove Docker images related to the application
- Remove dangling Docker volumes, excluding those with names ending in ".db"

### Clean Up the DB

To clean up the database, use the following command:

Please note that this action is irreversible and will result in the removal of all your data!

```bash
make clean_db
```

## Using it with another project

You can use these configurations with another project by executing them alongside that project.

Suppose you have this project located in a separate folder called "mongo" within another project. Please note that the order of execution is important. Run the MongoDB Docker Compose configurations first. Here's an example:

```bash
docker compose \
    --env-file mongo/mongo.properties --env-file mongo/.env -f mongo/docker-compose.mongo.yml \
    --env-file application.properties --env-file .env -f docker-compose.yml [build|up|down|...]
```
