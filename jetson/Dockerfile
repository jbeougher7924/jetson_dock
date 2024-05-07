# Use Nvidia CUDA devel image
FROM nvidia/cuda:12.4.1-devel-ubuntu22.04

# Install required packages
RUN apt-get update && apt-get install -y \
    gcc g++ \
    build-essential \
    cmake

# Set the working directory inside the container
WORKDIR /app

# Remove the build and jetson directories if they exist
RUN rm -rf ./build 
RUN rm -rf ./bin
RUN rm -rf ./hostess

# Copy the contents of the host's project directory into the container
COPY . /app

# Create a build directory and set it as the working directory
RUN mkdir -p build
RUN mkdir -p /app/bin/
WORKDIR /app/build

# Run CMake to configure the build
RUN cmake .. -DCMAKE_VERBOSE_MAKEFILE=ON

# Run make to compile the project
RUN make

# Set the entry point to run the compiled executable
ENTRYPOINT ["./my_executable"]

# Copy the built executable back to the host's bin directory

RUN mkdir -p /app/bin/ && cp my_executable /app/bin/