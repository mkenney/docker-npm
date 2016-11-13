#!/bin/bash

PREFIX="        "

CMD="$PROJECT_PATH/bin/yarn"
if [ "" != "$1" ]; then
    CMD="docker run --rm -ti -v $(pwd):/src:rw mkenney/npm:$1 /run-as-user /usr/local/bin/yarn"
fi
echo "CMD: $CMD"

cd $PROJECT_PATH/test/resources
rm -rf node_modules

output=$($CMD install)
result=$?
echo $output
if [ 0 -ne $result ]; then
    echo "${PREFIX}command failed: '$CMD install'"
    exit $result
fi

output=$(ls node_modules)
result=$?
echo $output
if [ 0 -ne $result ]; then
    echo "${PREFIX}command failed: 'ls node_modules'"
fi

exit $result