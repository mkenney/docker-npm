#!/bin/bash

PREFIX="        "
IMAGE_TAG=latest
if [ "" != "$1" ]; then
    IMAGE_TAG=$1
fi

CMD="docker run --rm -ti -v $PROJECT_PATH/test/resources:/src:rw mkenney/npm:$IMAGE_TAG /usr/local/bin/npm"

cd $PROJECT_PATH/test/resources
rm -rf node_modules
rm -f package.lock

$CMD install
result=$?
if [ 0 -ne $result ]; then
    echo "${PREFIX}command failed: '$CMD install'"
    exit $result
fi

ls node_modules
result=$?
if [ 0 -ne $result ]; then
    echo "${PREFIX}command failed: 'ls node_modules'"
fi
rm -rf node_modules
rm -f package.lock

exit $result
