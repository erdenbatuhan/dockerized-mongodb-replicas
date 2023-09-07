## Dockerized MongoDB Replicas

This project provides Docker configurations for creating MongoDB replicas.

### Running with Docker

Before running the containers, create the **.env** file and set the following environment variables:

```bash
APP_NAME= # The name of the application
MONGO_INITDB_DATABASE= # Databases initialized during MongoDB startup
```

To run the application with _Docker Compose_, use the following commands:

##### Building or rebuilding service(s):

```bash
docker-compose --env-file mongo.properties --env-file .env -f docker-compose.mongo.yml build
```

##### Creating and starting container(s):

```bash
docker-compose --env-file mongo.properties --env-file .env -f docker-compose.mongo.yml up
```

##### Stopping and removing container(s), network(s):

```bash
docker-compose --env-file mongo.properties --env-file .env -f docker-compose.mongo.yml down
```

### Using it with another project

You can use these configurations with another project by executing them alongside that project.

Suppose you have this project located in a separate folder called "mongo" within another project. Please note that the order of execution is important. Run the MongoDB Docker Compose configurations first. Here's an example:

```bash
docker-compose \
    --env-file mongo/mongo.properties --env-file mongo/.env -f mongo/docker-compose.mongo.yml \
    --env-file application.properties --env-file .env -f docker-compose.yml [build|up|down|...]
```

### Useful Commands:

##### Deleting all container(s):

```bash
docker rm -f $(docker ps -a -q)
```

##### Deleting all volume(s):

_!!! Be careful as it will remove all the data previously stored in the DB. If you wish to keep the data, skip this step. !!!_

```bash
docker volume rm $(docker volume ls -q)
```
