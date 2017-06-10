#!/bin/bash

PREFIX="        "

CMD="docker run --rm -ti -v $PROJECT_PATH/test/resources:/src:rw mkenney/npm:ci-build /run-as-user node"

cd $PROJECT_PATH/test/resources
rm -rf node_modules

output=`$CMD --version`
result=$?
if [ 0 -ne $result ]; then
    echo "${PREFIX}command failed: '$CMD --version'"
    echo $output
    exit $result
fi
