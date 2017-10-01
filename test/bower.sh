#!/bin/bash

PREFIX="        "
IMAGE_TAG=latest
if [ "" != "$1" ]; then
    IMAGE_TAG=$1
fi

CMD="docker run --rm -ti -v $PROJECT_PATH/test/resources:/src:rw mkenney/npm:$IMAGE_TAG /run-as-user /usr/local/bin/bower  --allow-root"

cd $PROJECT_PATH/test/resources
rm -rf bower_components

output=`$CMD install`
result=$?
if [ 0 -ne $result ]; then
    echo "${PREFIX}command failed: '$CMD install'"
    echo "${PREFIX}${PREFIX}${output}"
    exit $result
fi

output=`ls bower_components`
result=$?
if [ 0 -ne $result ]; then
    echo "${PREFIX}command failed: '$CMD ls bower_components'"
    echo "${PREFIX}${PREFIX}${output}"
fi
rm -rf bower_components

exit $result