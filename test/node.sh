#!/bin/bash

PREFIX="        "

CMD="$PROJECT_PATH/bin/node"
if [ "" != "$1" ]; then
    CMD="docker run --rm -ti -v $PROJECT_PATH/test/resources:/src:rw mkenney/npm:$1 /run-as-user /usr/local/bin/node"
fi

cd $PROJECT_PATH/test/resources
rm -rf node_modules

output=`$CMD --version`
result=$?
if [ 0 -ne $result ]; then
    echo "${PREFIX}command failed: '$CMD --version'"
    echo $output
    exit $result
fi
