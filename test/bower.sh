#!/bin/bash

CMD="$project_path/bin/bower"
if [ "" != "$1" ]; then
    CMD="docker run --rm -ti -v $(pwd):/src:rw mkenney/npm:$1 /run-as-user /usr/local/bin/bower"
fi

PREFIX="        "
project_path=$(dirname `pwd`)

cd $project_path/test/resources
rm -rf bower_components

output=$($CMD install)
result=$?
echo $output
if [ 0 -ne $result ]; then
    echo "${PREFIX}command failed: 'bower install'"
    exit $result
fi

output=$(ls bower_components)
result=$?
echo $output
if [ 0 -ne $result ]; then
    echo "${PREFIX}command failed: 'ls bower_components'"
    exit $result
fi

exit $result