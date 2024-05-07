#!/bin/bash

# Display a list of dangling images
docker images --filter "dangling=true" 

# Forcefully remove all dangling images
docker rmi -f $(docker images -q --filter "dangling=true") > /dev/null 2>&1

# Remove all stopped containers without confirmation
docker container prune -f > /dev/null 2>&1

docker images

docker ps -a

