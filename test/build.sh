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

failed_tests=
output=$(docker run --rm -ti -v $(pwd):/src:rw mkenney/npm:$TAG /run-as-user /usr/local/bin/node        --version); result=$?; echo $output; if [ 0 -ne $result ]; then build_result=1; failed_tests="$failed_tests node";  fi;
output=$(docker run --rm -ti -v $(pwd):/src:rw mkenney/npm:$TAG /run-as-user /usr/local/bin/bower       --version); result=$?; echo $output; if [ 0 -ne $result ]; then build_result=1; failed_tests="$failed_tests bower"; fi;
output=$(docker run --rm -ti -v $(pwd):/src:rw mkenney/npm:$TAG /run-as-user /usr/local/bin/npm         --version); result=$?; echo $output; if [ 0 -ne $result ]; then build_result=1; failed_tests="$failed_tests npm";   fi;
output=$(docker run --rm -ti -v $(pwd):/src:rw mkenney/npm:$TAG /run-as-user /usr/local/bin/yarn        --version); result=$?; echo $output; if [ 0 -ne $result ]; then build_result=1; failed_tests="$failed_tests yarn";  fi;
output=$(docker run --rm -ti -v $(pwd):/src:rw mkenney/npm:$TAG /run-as-user /usr/local/bin/generate-md --version); result=$?; echo $output; if [ 0 -ne $result ]; then build_result=1; failed_tests="$failed_tests md";    fi;
output=$(docker run --rm -ti -v $(pwd):/src:rw mkenney/npm:$TAG /run-as-user /usr/local/bin/grunt       --version); result=$?; echo $output; if [ 0 -ne $result ]; then build_result=1; failed_tests="$failed_tests grunt"; fi;
output=$(docker run --rm -ti -v $(pwd):/src:rw mkenney/npm:$TAG /run-as-user /usr/local/bin/gulp        --version); result=$?; echo $output; if [ 0 -ne $result ]; then build_result=1; failed_tests="$failed_tests gulp";  fi;

echo "Failed tests: $failed_tests"
exit $build_result
