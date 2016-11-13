#!/bin/bash

PREFIX="        "
TAG=ci-build
project_path=$(dirname `pwd`)

cd $project_path
docker build -t mkenney/npm:$TAG .
result=$?
echo $output
if [ 0 -ne $result ]; then
    echo "${PREFIX}command failed: 'docker build'"
fi

cd $project_path/test
build_result=0

docker run --rm -ti -v $(pwd):/src:rw mkenney/npm:$TAG /run-as-user /usr/local/bin/node --version

output=$(docker run --rm -ti -v $(pwd):/src:rw mkenney/npm:$TAG /run-as-user /usr/local/bin/node  --version); result=$?; echo $output; if [ 0 -ne $result ]; then build_result=1; fi;
output=$(docker run --rm -ti -v $(pwd):/src:rw mkenney/npm:$TAG /run-as-user /usr/local/bin/bower --version); result=$?; echo $output; if [ 0 -ne $result ]; then build_result=1; fi;
output=$(docker run --rm -ti -v $(pwd):/src:rw mkenney/npm:$TAG /run-as-user /usr/local/bin/npm   --version); result=$?; echo $output; if [ 0 -ne $result ]; then build_result=1; fi;
output=$(docker run --rm -ti -v $(pwd):/src:rw mkenney/npm:$TAG /run-as-user /usr/local/bin/yarn  --version); result=$?; echo $output; if [ 0 -ne $result ]; then build_result=1; fi;
output=$(docker run --rm -ti -v $(pwd):/src:rw mkenney/npm:$TAG /run-as-user /usr/local/bin/md    --version); result=$?; echo $output; if [ 0 -ne $result ]; then build_result=1; fi;
output=$(docker run --rm -ti -v $(pwd):/src:rw mkenney/npm:$TAG /run-as-user /usr/local/bin/grunt --version); result=$?; echo $output; if [ 0 -ne $result ]; then build_result=1; fi;
output=$(docker run --rm -ti -v $(pwd):/src:rw mkenney/npm:$TAG /run-as-user /usr/local/bin/gulp  --version); result=$?; echo $output; if [ 0 -ne $result ]; then build_result=1; fi;

exit $build_result