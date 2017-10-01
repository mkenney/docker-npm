#!/bin/bash

PREFIX="        "

NPM="docker run --rm -ti -v $PROJECT_PATH/test/resources:/src:rw mkenney/npm:$1 /run-as-user /usr/local/bin/npm"
CMD="docker run --rm -ti -v $PROJECT_PATH/test/resources:/src:rw mkenney/npm:$1 /run-as-user /usr/local/bin/grunt"

cd $PROJECT_PATH/test/resources
rm -rf node_modules
rm -f package.lock
$NPM install > /dev/null

output=`$CMD`
result=$?
if [ 0 -ne $result ]; then
    echo "${PREFIX}command failed: '$CMD'"
    echo "${PREFIX}${PREFIX}${output}"
fi
#rm -rf node_modules
#rm -f package.lock

exit $result