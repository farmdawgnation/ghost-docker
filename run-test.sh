#!/bin/bash

set -e

echo "Starting goss container"

GOSSIMAGE="aelsabbahy/goss"
GOSSCONTAINER=$(docker run -d $GOSSIMAGE)

echo "Starting ghost container"

IMAGE=$(docker build . -q)
GHOSTCONTAINER=$(docker run --rm --volumes-from $GOSSCONTAINER --mount type=bind,src=$(pwd)/goss.yaml,dst=/goss.yaml -d $IMAGE)

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
