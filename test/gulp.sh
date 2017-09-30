#!/bin/bash

PREFIX="        "

CMD="docker run --rm -ti -v $PROJECT_PATH/test/resources:/src:rw mkenney/npm:ci-build gulp"
NPM="docker run --rm -ti -v $PROJECT_PATH/test/resources:/src:rw mkenney/npm:ci-build npm"

cd $PROJECT_PATH/test/resources
rm -rf node_modules
$NPM install

$CMD
output=$($CMD)
result=$?
if [ 0 -ne $result ]; then
    echo "${PREFIX}command failed: '$CMD'"
    echo $output
    exit $result
fi
