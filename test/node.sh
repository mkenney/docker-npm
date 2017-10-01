#!/bin/bash

PREFIX="        "
IMAGE_TAG=latest
if [ "" != "$1" ]; then
    IMAGE_TAG=$1
fi

CMD="docker run --rm -ti -v $PROJECT_PATH/test/resources:/src:rw mkenney/npm:$IMAGE_TAG /run-as-user /usr/local/bin/node"

output=`$CMD --version`
result=$?
if [ 0 -ne $result ]; then
    echo "${PREFIX}command failed: '$CMD --version'"
    echo "${PREFIX}${PREFIX}${output}"
fi

exit $result