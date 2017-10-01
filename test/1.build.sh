#!/bin/bash

source $PROJECT_PATH/test/lib/list-changes.sh

PREFIX="        "
DOCKER_NPM_TAG=ci-build
failed_tests=

for dockerfile in $(list_changes Dockerfile); do
    if [ -f $PROJECT_PATH/$dockerfile ]; then
        printf "\n\n\n -------- Building $dockerfile -------- \n\n\n"
        build_result=0

        echo "    ...build"
        cd $PROJECT_PATH/$(dirname $dockerfile)
        docker build -t mkenney/npm:$DOCKER_NPM_TAG .
        result=$?
        if [ 0 -ne $result ]; then
            echo "${PREFIX}$dockerfile build failed"
            exit 1
        fi
        cd $PROJECT_PATH/test

        echo "    ...node"
        output=`sh ./node.sh $DOCKER_NPM_TAG`
        result=$?
        echo $output
        if [ 0 -ne $result ]; then
            build_result=1
            failed_tests="$failed_tests node"
        fi;

        echo "    ...bower"
        output=`sh ./bower.sh $DOCKER_NPM_TAG`
        result=$?
        echo $output
        if [ 0 -ne $result ]; then
            build_result=1
            failed_tests="$failed_tests bower";
        fi;

        echo "    ...npm"
        output=`sh ./npm.sh $DOCKER_NPM_TAG`
        result=$?
        echo $output
        if [ 0 -ne $result ]; then
            build_result=1
            failed_tests="$failed_tests npm";
        fi;

        echo "    ...yarn"
        output=`sh ./yarn.sh $DOCKER_NPM_TAG`
        result=$?
        echo $output
        if [ 0 -ne $result ]; then
            build_result=1
            failed_tests="$failed_tests yarn"
        fi;

        echo "    ...grunt"
        output=`sh ./grunt.sh $DOCKER_NPM_TAG`
        result=$?
        echo $output
        if [ 0 -ne $result ]; then
            build_result=1
            failed_tests="$failed_tests grunt";
        fi;

        echo "    ...gulp"
        output=`sh ./gulp.sh $DOCKER_NPM_TAG`
        result=$?
        echo $output
        if [ 0 -ne $result ]; then
            build_result=1
            failed_tests="$failed_tests gulp"
        fi;

        echo "    ...markdown-styles"
        output=`sh ./md.sh $DOCKER_NPM_TAG`
        result=$?
        echo $output
        if [ 0 -ne $result ]; then
            build_result=1
            failed_tests="$failed_tests md";
        fi;

        if [ 0 -ne $build_result ]; then
            echo "${PREFIX}Build tests failed: $failed_tests"
            printf "\n\n\n -------- $dockerfile build tests failed -------- \n\n\n"
            exit $build_result;
        fi
        printf "\n\n\n -------- $dockerfile build tests succeeded -------- \n\n\n"

        sh $PROJECT_PATH/test/ci/deploy.sh $(dirname $dockerfile)
    fi
done

exit $build_result
