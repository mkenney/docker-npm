#!/bin/bash

PREFIX="        "

CMD="$PROJECT_PATH/bin/yarn"
if [ "" != "$1" ]; then
    CMD="docker run --rm -ti -v $PROJECT_PATH/test/resources:/src:rw mkenney/npm:$1 /run-as-user /usr/local/bin/yarn"
fi

cd $PROJECT_PATH/test/resources
rm -rf node_modules

output=`$CMD install`
result=$?
if [ 0 -ne $result ]; then
    echo "${PREFIX}command failed: '$CMD install'"
    echo $output
    exit $result
fi

output=`ls node_modules`
result=$?
if [ 0 -ne $result ]; then
    echo "${PREFIX}command failed: 'ls node_modules'"
    echo $output
    exit $result
fi
