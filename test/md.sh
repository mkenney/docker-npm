#!/bin/bash

PREFIX="        "
project_path=$(dirname `pwd`)

CMD="$project_path/bin/generate-md"
if [ "" != "$1" ]; then
    CMD="docker run --rm -ti -v $(pwd):/src:rw mkenney/npm:$1 /run-as-user /usr/local/bin/generate-md"
fi

cd $project_path/test/resources
rm -rf html

output=$($CMD --input md --output html > /dev/null 2>&1)
result=$?
echo $output
if [ 0 -ne $result ]; then
    echo "${PREFIX}command failed: 'generate-md'"
    exit $result
fi

output=$(ls $project_path/test/resources/html)
result=$?
echo $output
if [ 0 -ne $result ]; then
    echo "${PREFIX}command failed: 'ls html'"
fi

exit $result