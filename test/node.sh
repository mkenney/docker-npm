#!/bin/bash

PREFIX="        "

CMD="$PROJECT_PATH/bin/node"
if [ "" != "$1" ]; then
    CMD="docker run --rm -ti -v $(pwd):/src:rw mkenney/npm:$1 /run-as-user /usr/local/bin/node"
fi
echo "CMD: $CMD"

cd $PROJECT_PATH/test/resources
rm -rf node_modules

output=$($CMD --version)
result=$?
echo $output
if [ 0 -ne $result ]; then
    echo "${PREFIX}command failed: 'node --version'"
fi
exit $result