#!/bin/bash

CMD=$project_path/bin/gulp
if [ "" != "$1" ]; then
    CMD=docker run --rm -ti -v $(pwd):/src:rw mkenney/npm:$1 /run-as-user /usr/local/bin/gulp
fi

PREFIX="        "
project_path=$(dirname `pwd`)

cd $project_path/test/resources
rm -rf node_modules

output=$($CMD)
result=$?
echo $output
if [ 0 -ne $result ]; then
    echo "${PREFIX}command failed: 'gulp'"
fi
exit $result