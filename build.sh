#!/usr/bin/env bash

set -ex

# SET THE FOLLOWING VARIABLES
# docker hub username

USERNAME=delutz

# image name
IMAGE=output-json

docker build -t $USERNAME/$IMAGE:latest .