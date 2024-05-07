#!/bin/bash

# Build Docker image with tag 'my-nvidia-image' from the current directory
docker build -t my-nvidia-image ./

# Run the Docker container
container_id=$(docker run -d my-nvidia-image)

# Copy the built executable back to the host's bin directory
docker cp $container_id:/app/bin/my_executable /mnt/q/src/c++/jetson/bin/

# Stop and remove the container
docker rm -f $container_id

# run the container
docker run -it --rm my-nvidia-image bash

docker ps -a

docker images