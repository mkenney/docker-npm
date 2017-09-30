#!/bin/bash

PREFIX="        "
build_result=0
failed_tests=

cd $PROJECT_PATH
docker build --no-cache -t mkenney/npm:ci-build .
result=$?
if [ 0 -ne $result ]; then
    build_result=1
    failed_tests="$failed_tests docker-build"
fi
cd $PROJECT_PATH/test

echo "executing node.sh"
output=$(bash ./node.sh)
result=$?
echo $output
if [ 0 -ne $result ]; then
    build_result=1
    failed_tests="$failed_tests node"
fi;

echo "executing bower.sh"
output=$(bash ./bower.sh)
result=$?
echo $output
if [ 0 -ne $result ]; then
    build_result=1
    failed_tests="$failed_tests bower";
fi;

echo "executing npm.sh"
output=$(bash ./npm.sh)
result=$?
echo $output
if [ 0 -ne $result ]; then
    build_result=1
    failed_tests="$failed_tests npm";
fi;

echo "executing yarn.sh"
output=$(bash ./yarn.sh)
result=$?
echo $output
if [ 0 -ne $result ]; then
    build_result=1
    failed_tests="$failed_tests yarn"
fi;

echo "executing md.sh"
output=$(bash ./md.sh)
result=$?
echo $output
if [ 0 -ne $result ]; then
    build_result=1
    failed_tests="$failed_tests md";
fi;

echo "executing grunt.sh"
output=$(bash ./grunt.sh)
result=$?
echo $output
if [ 0 -ne $result ]; then
    build_result=1
    failed_tests="$failed_tests grunt";
fi;

echo "executing gulp.sh"
output=$(bash ./gulp.sh)
result=$?
echo $output
if [ 0 -ne $result ]; then
    build_result=1
    failed_tests="$failed_tests gulp"
fi;

if [ 0 -ne $build_result ]; then
    echo "${PREFIX}build.sh tests failed: $failed_tests"
fi
exit $build_result
