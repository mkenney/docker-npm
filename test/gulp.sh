#!/bin/bash

PREFIX="        "

CMD="$PROJECT_PATH/bin/gulp"
NPM="$PROJECT_PATH/bin/npm"
if [ "" != "$1" ]; then
    CMD="docker run --rm -ti -v $PROJECT_PATH/test/resources:/src:rw mkenney/npm:$1 /run-as-user /usr/local/bin/gulp"
    NPM="docker run --rm -ti -v $PROJECT_PATH/test/resources:/src:rw mkenney/npm:$1 /run-as-user /usr/local/bin/npm"
fi
echo "CMD: $CMD"

cd $PROJECT_PATH/test/resources
echo "rm -rf node_modules"
rm -rf node_modules
echo "$NPM install"
$NPM install

output=`$CMD`
result=$?
echo $output
if [ 0 -ne $result ]; then
    echo "${PREFIX}command failed: '$CMD': $output"
fi
exit $result