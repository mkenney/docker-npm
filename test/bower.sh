#!/bin/bash

PREFIX="        "

CMD="$PROJECT_PATH/bin/bower"
if [ "" != "$1" ]; then
    CMD="docker run --rm -ti -v $PROJECT_PATH/test/resources:/src:rw mkenney/npm:$1 /run-as-user /usr/local/bin/bower"
fi

cd $PROJECT_PATH/test/resources
rm -rf bower_components

output=`$CMD install`
result=$?
echo $output
if [ 0 -ne $result ]; then
    echo "${PREFIX}command failed: '$CMD install'"
    exit $result
fi

output=`ls bower_components`
result=$?
if [ 0 -ne $result ]; then
    echo "${PREFIX}command failed: 'ls bower_components'"
    echo $output
    exit $result
fi

exit $result