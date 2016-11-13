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

output=$(docker run --rm -ti -v $(pwd):/src:rw mkenney/npm:$TAG /run-as-user /usr/local/bin/ node  --version); echo $output; result=$?; if [ 0 -ne $result ]; then build_result=1; fi;
output=$(docker run --rm -ti -v $(pwd):/src:rw mkenney/npm:$TAG /run-as-user /usr/local/bin/ bower --version); echo $output; result=$?; if [ 0 -ne $result ]; then build_result=1; fi;
output=$(docker run --rm -ti -v $(pwd):/src:rw mkenney/npm:$TAG /run-as-user /usr/local/bin/ npm   --version); echo $output; result=$?; if [ 0 -ne $result ]; then build_result=1; fi;
output=$(docker run --rm -ti -v $(pwd):/src:rw mkenney/npm:$TAG /run-as-user /usr/local/bin/ yarn  --version); echo $output; result=$?; if [ 0 -ne $result ]; then build_result=1; fi;
output=$(docker run --rm -ti -v $(pwd):/src:rw mkenney/npm:$TAG /run-as-user /usr/local/bin/ md    --version); echo $output; result=$?; if [ 0 -ne $result ]; then build_result=1; fi;
output=$(docker run --rm -ti -v $(pwd):/src:rw mkenney/npm:$TAG /run-as-user /usr/local/bin/ grunt --version); echo $output; result=$?; if [ 0 -ne $result ]; then build_result=1; fi;
output=$(docker run --rm -ti -v $(pwd):/src:rw mkenney/npm:$TAG /run-as-user /usr/local/bin/ gulp  --version); echo $output; result=$?; if [ 0 -ne $result ]; then build_result=1; fi;

exit $build_result