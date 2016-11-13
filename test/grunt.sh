#!/bin/bash

PREFIX="        "

CMD="$PROJECT_PATH/bin/grunt"
NPM="$PROJECT_PATH/bin/npm"
if [ "" != "$1" ]; then
    CMD="docker run --rm -ti -v $(pwd):/src:rw mkenney/npm:$1 /run-as-user /usr/local/bin/grunt"
    NPM="docker run --rm -ti -v $(pwd):/src:rw mkenney/npm:$1 /run-as-user /usr/local/bin/npm"
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
    echo "PWD:"
    echo `pwd`
    echo "LS:"
    echo `ls -laF`
fi
exit $result