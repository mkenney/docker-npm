#!/bin/bash

CMD=$project_path/bin/node
if [ "" != "$1" ]; then
    CMD=docker run --rm -ti -v $(pwd):/src:rw mkenney/npm:$1 /run-as-user /usr/local/bin/node
fi

PREFIX="        "
project_path=$(dirname `pwd`)

cd $project_path/test/resources
rm -rf node_modules

output=$($CMD --version)
result=$?
echo $output
if [ 0 -ne $result ]; then
    echo "${PREFIX}command failed: 'node --version'"
fi
exit $result