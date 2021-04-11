export DOCKER_ORG ?= cloudposse
export DOCKER_IMAGE ?= $(DOCKER_ORG)/atmos
export DOCKER_TAG ?= latest
export DOCKER_IMAGE_NAME ?= $(DOCKER_IMAGE):$(DOCKER_TAG)

-include $(shell curl -sSL -o .build-harness "https://git.io/build-harness"; echo .build-harness)

## Lint terraform code
lint:
	$(SELF) terraform/install terraform/get-modules terraform/get-plugins terraform/lint terraform/validate

## Initialize build-harness, install deps, build docker container, install wrapper script and run shell
all: init deps build run
	@exit 0

## Install dependencies (if any)
deps:
	@exit 0

## Build docker image
build:
	@make --no-print-directory docker/build

run:
	@docker run -it \
				--rm \
				--volume "$$HOME":/localhost \
				--volume "$$PWD":/components \
				--volume "$$PWD":/stacks \
				cloudposse/atmos:latest;

