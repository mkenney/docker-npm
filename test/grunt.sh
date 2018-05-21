#!/bin/bash

PREFIX="        "
IMAGE_TAG=latest
if [ "" != "$1" ]; then
    IMAGE_TAG=$1
fi

NPM="docker run --rm -ti -v $PROJECT_PATH/test/resources:/src:rw mkenney/npm:$IMAGE_TAG /usr/local/bin/npm"
CMD="docker run --rm -ti -v $PROJECT_PATH/test/resources:/src:rw mkenney/npm:$IMAGE_TAG /usr/local/bin/grunt"

cd $PROJECT_PATH/test/resources
rm -rf node_modules
rm -f package.lock
$NPM install
$NPM cache clean

$CMD
result=$?
if [ 0 -ne $result ]; then
    echo "${PREFIX}command failed: '$CMD'"
fi
rm -rf node_modules
rm -f package.lock

exit $result
