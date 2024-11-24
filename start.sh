#!/bin/bash

# Run with the command './start.sh'
# Builds the Docker image and runs a new container.

IMAGE_NAME=image_a
CONTAINER_NAME=container_a
if [ "$(docker ps -aq -f name=$CONTAINER_NAME)" ]; then
        echo "Starting..."
        docker start $CONTAINER_NAME
else
        echo "Building new Docker image"
        docker build -t $IMAGE_NAME .
        echo "Starting..."
        docker run --name $CONTAINER_NAME --rm -it $IMAGE_NAME
fi
