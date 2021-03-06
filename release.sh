#!/usr/bin/env bash

set -ex

# SET THE FOLLOWING VARIABLES
# docker hub username
USERNAME=delutz
# image name
IMAGE=output-json

# ensure we're up to date
git stash
git pull
git stash pop

version=`cat VERSION`
echo "version: $version"

# run build
./build.sh

# tag it
git add -A
git commit -m "version $version"
git tag -a "$version" -m "version $version"
git push
git push --tags

docker tag $USERNAME/$IMAGE:latest $USERNAME/$IMAGE:$version

# push it
docker push $USERNAME/$IMAGE:$version
docker push $USERNAME/$IMAGE:latest
