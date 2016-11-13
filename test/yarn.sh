#!/bin/bash

PREFIX="        "
project_path=$(dirname `pwd`)

CMD="$project_path/bin/yarn"
if [ "" != "$1" ]; then
    CMD="docker run --rm -ti -v $(pwd):/src:rw mkenney/npm:$1 /run-as-user /usr/local/bin/yarn"
fi

cd $project_path/test/resources
rm -rf node_modules

output=$($CMD install)
result=$?
echo $output
if [ 0 -ne $result ]; then
    echo "${PREFIX}command failed: 'yarn install'"
    exit $result
fi

output=$(ls node_modules)
result=$?
echo $output
if [ 0 -ne $result ]; then
    echo "${PREFIX}command failed: 'ls node_modules'"
fi

exit $result