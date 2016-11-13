#!/bin/bash

PREFIX="        "

CMD="$PROJECT_PATH/bin/grunt"
if [ "" != "$1" ]; then
    CMD="docker run --rm -ti -v $(pwd):/src:rw mkenney/npm:$1 /run-as-user /usr/local/bin/grunt"
fi

cd $PROJECT_PATH/test/resources
rm -rf node_modules

output=$($CMD)
result=$?
echo $output
if [ 0 -ne $result ]; then
    echo "${PREFIX}command failed: 'grunt'"
fi
exit $result