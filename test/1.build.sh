#!/bin/bash

source $PROJECT_PATH/test/lib/list-changes.sh

PREFIX="        "
failed_tests=
build_tag=ci-build

for dockerfile in $(list_changes Dockerfile); do
    if [ -f $PROJECT_PATH/$dockerfile ]; then
        printf "\n\n\n -------- Building $dockerfile -------- \n\n\n"
        build_result=0

        echo "    ...build"
        cd $PROJECT_PATH/$(dirname $dockerfile)
        docker build -t mkenney/npm:$build_tag .
        result=$?
        if [ 0 -ne $result ]; then
            echo "${PREFIX}$dockerfile build failed"
            exit 1
        fi
        cd $PROJECT_PATH/test

        echo "    ...node"
        sh ./node.sh $build_tag
        result=$?
        echo $output
        if [ 0 -ne $result ]; then
            build_result=1
            failed_tests="$failed_tests node"
        fi;

        echo "    ...bower"
        sh ./bower.sh $build_tag
        result=$?
        echo $output
        if [ 0 -ne $result ]; then
            build_result=1
            failed_tests="$failed_tests bower";
        fi;

        echo "    ...npm"
        sh ./npm.sh $build_tag
        result=$?
        echo $output
        if [ 0 -ne $result ]; then
            build_result=1
            failed_tests="$failed_tests npm";
        fi;

        if \
            [ "node-6.9-alpine/Dockerfile" != "$dockerfile" ] \
            && [ "node-6.9-debian/Dockerfile" != "$dockerfile" ] \
            && [ "node-7.0-debian/Dockerfile" != "$dockerfile" ] \
            && [ "node-7.7-alpine/Dockerfile" != "$dockerfile" ] \
        ; then
            echo "    ...npx"
            sh ./npx.sh $build_tag
            result=$?
            echo $output
            if [ 0 -ne $result ]; then
                build_result=1
                failed_tests="$failed_tests npx"
            fi
        fi

        echo "    ...yarn"
        sh ./yarn.sh $build_tag
        result=$?
        echo $output
        if [ 0 -ne $result ]; then
            build_result=1
            failed_tests="$failed_tests yarn"
        fi;

        echo "    ...grunt"
        sh ./grunt.sh $build_tag
        result=$?
        echo $output
        if [ 0 -ne $result ]; then
            build_result=1
            failed_tests="$failed_tests grunt";
        fi;

        echo "    ...gulp"
        sh ./gulp.sh $build_tag
        result=$?
        echo $output
        if [ 0 -ne $result ]; then
            build_result=1
            failed_tests="$failed_tests gulp"
        fi;

        echo "    ...markdown-styles"
        sh ./md.sh $build_tag
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

    fi
done

exit $build_result
