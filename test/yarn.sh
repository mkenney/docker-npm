#!/bin/bash

PREFIX="        "
IMAGE_TAG=latest
if [ "" != "$1" ]; then
    IMAGE_TAG=$1
fi

CMD="docker run --rm -ti -v $PROJECT_PATH/test/resources:/src:rw mkenney/npm:$IMAGE_TAG /usr/local/bin/yarn"

cd $PROJECT_PATH/test/resources
rm -rf node_modules
rm -f yarn.lock

output=`$CMD install`
result=$?
if [ 0 -ne $result ]; then
    echo "${PREFIX}command failed: '$CMD install'"
    echo "${PREFIX}${PREFIX}${output}"
    exit $result
fi

output=`ls node_modules`
result=$?
if [ 0 -ne $result ]; then
    echo "${PREFIX}command failed: 'ls node_modules'"
    echo "${PREFIX}${PREFIX}${output}"
fi
rm -rf node_modules
rm -f yarn.lock

exit $result
