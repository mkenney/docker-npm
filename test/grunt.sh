#!/bin/bash

PREFIX="        "

CMD="$PROJECT_PATH/bin/grunt"
NPM="$PROJECT_PATH/bin/npm"
if [ "" != "$1" ]; then
    CMD="docker run --rm -ti -v $PROJECT_PATH/test/resources:/src:rw mkenney/npm:$1 /run-as-user /usr/local/bin/grunt"
    NPM="docker run --rm -ti -v $PROJECT_PATH/test/resources:/src:rw mkenney/npm:$1 /run-as-user /usr/local/bin/npm"
fi

cd $PROJECT_PATH/test/resources
rm -rf node_modules
$NPM install

output=`$CMD`
result=$?
if [ 0 -ne $result ]; then
    echo "${PREFIX}command failed: '$CMD'"
    echo $output
    exit $result
fi
