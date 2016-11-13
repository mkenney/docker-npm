#!/bin/bash

PREFIX="        "

CMD="$PROJECT_PATH/bin/bower"
if [ "" != "$1" ]; then
    CMD="docker run --rm -ti -v $(pwd):/src:rw mkenney/npm:$1 /run-as-user /usr/local/bin/bower"
fi
echo "CMD: $CMD"

cd $PROJECT_PATH/test/resources
rm -rf bower_components

output=$($CMD install)
result=$?
echo $output
if [ 0 -ne $result ]; then
    echo "${PREFIX}command failed: '$CMD install': $output"
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