#!/bin/bash

PREFIX="        "

CMD="docker run --rm -ti -v $PROJECT_PATH/test/resources:/src:rw mkenney/npm:ci-build /run-as-user generate-md"

cd $PROJECT_PATH/test/resources
rm -rf html

output=`$CMD --input md --output html > /dev/null 2>&1`
result=$?
if [ 0 -ne $result ]; then
    echo "${PREFIX}command failed: '$CMD'"
    echo $output
    exit $result
fi

output=`ls $PROJECT_PATH/test/resources/html`
result=$?
if [ 0 -ne $result ]; then
    echo "${PREFIX}command failed: 'ls html'"
    echo $output
    exit $result
fi
