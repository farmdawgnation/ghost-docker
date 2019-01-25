#!/bin/bash

START_YELLOW="\e[93m"
START_BOLD="\e[1m"
RESET_FORMAT="\e[0m"

set -e

echo "Starting goss container"

GOSSIMAGE="aelsabbahy/goss"
GOSSCONTAINER=$(docker run -d $GOSSIMAGE)

echo "Goss container is $GOSSCONTAINER"

echo "travis_fold:start:image_build"

echo "$START_BOLD $START_YELLOW Building ghost image$RESET_FORMAT"

docker build .

echo "travis_fold:end:image_build"

echo "Determining ghost container id"

IMAGE=$(docker images -q | head -n 1)

echo "Pretty sure the ghost image is $IMAGE"

echo "Starting ghost container"

GHOSTCONTAINER=$(docker run --rm --volumes-from $GOSSCONTAINER --mount type=bind,src=$(pwd)/goss.yaml,dst=/goss.yaml -d $IMAGE)

echo "Ghost container is $GHOSTCONTAINER"

echo "Giving ghost 20 seconds to start"

sleep 20

set +e

echo "Running goss assertions against ghost container"

docker exec -it $GHOSTCONTAINER /goss/goss -g /goss.yaml validate
code=$?

set -e

echo "Shutting down containers"

docker stop $GHOSTCONTAINER
docker rm $GOSSCONTAINER

if [[ $code -eq 0 ]]; then
  echo "Tests successful"
else
  echo "Tests failed"
fi

exit $code
