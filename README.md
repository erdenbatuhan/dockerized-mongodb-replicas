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

This command will remove images, containers, volumes (e.g., dangling volumes such as dangling Docker volumes such as _0c18b ... 362cf_), networks, and orphaned containers.

```bash
make clean
```

### Clean Up the DB

To clean up the database, use the following command:

Please note that this action is irreversible and will result in the removal of all your data!

```bash
make clean_db
```

## Using it with another project

You can use these configurations with another project by executing them alongside that project. Consider a scenario where your project is situated in a distinct folder named **mongo** within another project. 

The following is an example that is executed from one directory above.

**Important Points:**
- It's vital to emphasize that the sequence of execution matters. The Docker Compose configuration file for MongoDB should be executed after the main project's file. This precaution is essential because, when working with multiple Compose files, it's imperative to confirm that all specified paths within these files are relative to the primary Compose file, which is the first one specified using the **-f** flag.
- Please note that the _environment variables_ also override each other.

```bash
MONGO_DIR=./mongo # To ensure that this environment variable takes precedence over the one defined in the project's environment variable files, please set it in the root directory of the main project.

docker compose \
  --env-file ${MONGO_DIR}/.env \
  --env-file ./.env \
  --env-file ${MONGO_DIR}/mongo.properties \
  --env-file ./application.properties \
  -f docker-compose.yml -f ${MONGO_DIR}/docker-compose.mongo.yml [build|up|down|...]
```
