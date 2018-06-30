.PHONY: requirements image help
.PHONY: build run tests clean
.PHONY: _run _tests

.DEFAULT_GOAL: help

# Make sure the default shell is Bash (I'm looking at you Ubuntu!)
SHELL := /bin/bash

PWD := $(shell pwd)

DOCKER_IMAGE := api:makefile

# This "function" will allow us to call Docker easily in the targets below
define docker_make
	sudo docker run -it --rm -e USER_ID=$(shell id -u) -v ${PWD}:${PWD}:Z --network=host ${DOCKER_IMAGE} "cd ${PWD} && make $1"
endef

PYTHON_FILES = $(shell find api/ -name '*.py')


define HELP_CONTENT
make build   Build the app (create a Pex out of it).
make clean   Clean built software and downloaded libraries.
make help    Display this help.
make run     Run the app (for development purposes).
make tests   Test the app.
endef
export HELP_CONTENT

help:
	@echo "$$HELP_CONTENT"


clean:
	$(RM) -r venv/
	$(RM) -r api.egg-info/
	$(RM) -r .pytest_cache/
	find . -type f -name '*.pyc' -delete
	find . -type d -name '__pycache__' -delete
	sudo docker images | grep -E 'api\s+makefile' && sudo docker rmi ${DOCKER_IMAGE} || true


# Check that Docker is installed
requirements:
	@command -v docker &>/dev/null || { echo 'You need docker, please install it first'; exit 1; }

# Build the Docker image
image: requirements
	cd docker/ && sudo docker build . -t ${DOCKER_IMAGE}

build: image
	$(call docker_make,api.pex)

run: image
	$(call docker_make,_run)

tests: image
	$(call docker_make,_tests)


# The following targets will be run in the Docker container

# Only build the virtualenv when needed
venv/:
	virtualenv-3.4 $@

api.pex: ${PYTHON_FILES} requirements/run.txt requirements/build.txt venv/
	venv/bin/pip3.4 install -e . -r requirements/run.txt -r requirements/build.txt
	venv/bin/pex . -r requirements/run.txt --script api --output $@

_run: venv/
	venv/bin/pip3.4 install -e . -r requirements/run.txt
	venv/bin/python3.4 api/

_tests: venv/
	venv/bin/pip3.4 install -e . -r requirements/run.txt -r requirements/tests.txt
	venv/bin/pytest tests/
