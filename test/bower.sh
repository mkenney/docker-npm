#!/bin/bash

PREFIX="        "
IMAGE_TAG=latest
if [ "" != "$1" ]; then
    IMAGE_TAG=$1
fi

docker run --rm -ti -v $PROJECT_PATH/test/resources:/src:rw mkenney/npm:$IMAGE_TAG whoami

CMD="docker run --rm -ti -v $PROJECT_PATH/test/resources:/src:rw mkenney/npm:$IMAGE_TAG /usr/local/bin/bower  --allow-root"

cd $PROJECT_PATH/test/resources
rm -rf bower_components

$CMD install
result=$?
if [ 0 -ne $result ]; then
    echo "${PREFIX}command failed: '$CMD install'"
    exit $result
fi

ls -laF bower_components/jquery/src/deprecated.js

ls bower_components
result=$?
if [ 0 -ne $result ]; then
    echo "${PREFIX}${PREFIX}${output}"
fi
rm -rf bower_components

exit $result
