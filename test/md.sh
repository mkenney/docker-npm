#!/bin/bash

PREFIX="        "
IMAGE_TAG=latest
if [ "" != "$1" ]; then
    IMAGE_TAG=$1
fi

CMD="docker run --rm -ti -v $PROJECT_PATH/test/resources:/src:rw mkenney/npm:$IMAGE_TAG /run-as-user /usr/local/bin/generate-md"

cd $PROJECT_PATH/test/resources
rm -rf html

output=`$CMD --input md --output html > /dev/null 2>&1`
result=$?
if [ 0 -ne $result ]; then
    echo "${PREFIX}command failed: '$CMD'"
    echo "${PREFIX}${PREFIX}${output}"
    exit $result
fi

output=`ls $PROJECT_PATH/test/resources/html`
result=$?
if [ 0 -ne $result ]; then
    echo "${PREFIX}command failed: 'ls html'"
    echo "${PREFIX}${PREFIX}${output}"
fi

exit $result