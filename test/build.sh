#!/bin/bash

PREFIX="        "
TAG=ci-build
build_result=0
failed_tests=

cd $PROJECT_PATH
docker build -t mkenney/npm:$TAG .
result=$?
if [ 0 -ne $result ]; then
    build_result=1
    failed_tests="$failed_tests docker-build"
fi
cd $PROJECT_PATH/test

output=`sh ./node.sh $TAG`
result=$?;
echo $output;
if [ 0 -ne $result ]; then
    build_result=1
    failed_tests="$failed_tests node"
fi;

output=`sh ./bower.sh $TAG`
result=$?;
echo $output;
if [ 0 -ne $result ]; then
    build_result=1
    failed_tests="$failed_tests bower";
fi;

output=`sh ./npm.sh $TAG`
result=$?;
echo $output;
if [ 0 -ne $result ]; then
    build_result=1
    failed_tests="$failed_tests npm";
fi;

output=`sh ./yarn.sh $TAG`
result=$?;
echo $output;
if [ 0 -ne $result ]; then
    build_result=1
    failed_tests="$failed_tests yarn"
fi;

output=`sh ./md.sh $TAG`
result=$?;
echo $output;
if [ 0 -ne $result ]; then
    build_result=1
    failed_tests="$failed_tests md";
fi;

output=`sh ./grunt.sh $TAG`
result=$?;
echo $output;
if [ 0 -ne $result ]; then
    build_result=1
    failed_tests="$failed_tests grunt";
fi;

output=`sh ./gulp.sh $TAG`
result=$?;
echo $output;
if [ 0 -ne $result ]; then
    build_result=1
    failed_tests="$failed_tests gulp"
fi;


if [ 0 -ne $build_result ]; then
    echo "${PREFIX}Build tests failed: $failed_tests"
fi
exit $build_result
