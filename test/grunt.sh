#!/bin/bash

PREFIX="        "
IMAGE_TAG=latest
if [ "" != "$1" ]; then
    IMAGE_TAG=$1
fi

YARN="docker run --rm -ti -v $PROJECT_PATH/test/resources:/src:rw mkenney/npm:$IMAGE_TAG /usr/local/bin/yarn"
CMD="docker run --rm -ti -v $PROJECT_PATH/test/resources:/src:rw mkenney/npm:$IMAGE_TAG /usr/local/bin/grunt"

cd $PROJECT_PATH/test/resources
rm -rf node_modules
rm -f package.lock
$YARN install

result=$?
if [ 0 -ne $result ]; then
    echo "${PREFIX}command failed: '$YARN install'"
    exit $result
fi

$CMD
result=$?
if [ 0 -ne $result ]; then
    echo "${PREFIX}command failed: '$CMD'"
fi
rm -rf node_modules
rm -f package.lock

exit $result
