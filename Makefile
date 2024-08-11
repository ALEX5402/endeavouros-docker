# Name of the Docker image
IMAGE_NAME := endeavouros:latest

# BuildKit environment variable
BUILDKIT := DOCKER_BUILDKIT=0

# Dockerfile path (adjust if your Dockerfile is in a different directory)
DOCKERFILE := Dockerfile

# Target to build the Docker image
.PHONY: build
build:
	$(BUILDKIT) docker build -t $(IMAGE_NAME) -f $(DOCKERFILE) .

# Target to clean up intermediate images and containers
.PHONY: clean
clean:
	docker rmi -f endeavouros:latest 

# Target to remove the Docker image
.PHONY: remove
remove:
	docker rmi $(IMAGE_NAME)

# Target to run the Docker container interactively
.PHONY: run
run:
	docker run -it $(IMAGE_NAME) /bin/bash

# Target to list all Docker images
.PHONY: images
images:
	docker images

# Target to list all Docker containers
.PHONY: ps
ps:
	docker ps -a

# Target to stop all running containers
.PHONY: stop
stop:
	docker stop $(shell docker ps -q)

# Target to remove all stopped containers
.PHONY: remove-containers
remove-containers:
	docker rm $(shell docker ps -a -q)
