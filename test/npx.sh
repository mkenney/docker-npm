#!/bin/bash

PREFIX="        "
IMAGE_TAG=latest
if [ "" != "$1" ]; then
    IMAGE_TAG=$1
fi

NPM="docker run --rm -ti -v $PROJECT_PATH/test/resources:/src:rw mkenney/npm:$IMAGE_TAG /usr/local/bin/npm"
CMD="docker run --rm -ti -v $PROJECT_PATH/test/resources:/src:rw mkenney/npm:$IMAGE_TAG /usr/local/bin/npx"

cd $PROJECT_PATH/test/resources
rm -rf node_modules
rm -f package.lock
$NPM install
result=$?
if [ 0 -ne $result ]; then
    echo "${PREFIX}command failed: '$NPM install'"
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
