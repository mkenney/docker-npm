#!/bin/bash

PREFIX="        "

CMD="$PROJECT_PATH/bin/npm"
if [ "" != "$1" ]; then
    CMD="docker run --rm -ti -v $PROJECT_PATH/test/resources:/src:rw mkenney/npm:$1 /run-as-user /usr/local/bin/npm"
fi
echo "CMD: $CMD"

cd $PROJECT_PATH/test/resources
rm -rf node_modules

output=$($CMD install)
result=$?
echo $output
if [ 0 -ne $result ]; then
    echo "${PREFIX}command failed: '$CMD install': $output"
    exit $result
fi

output=$(ls node_modules)
result=$?
echo $output
if [ 0 -ne $result ]; then
    echo "${PREFIX}command failed: 'ls node_modules'"
    exit $result
fi

exit $result