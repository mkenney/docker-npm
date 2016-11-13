#!/bin/bash

INSTALL_PATH=bin
PREFIX="        "

# storage
mkdir -p $INSTALL_PATH
rm -f $INSTALL_PATH/*

function test_script {
    script=$1

    # Test script
    output=$($(dirname `pwd`)/bin/$script --version)
    result=$?
    echo "${PREFIX}        $script --version: $output"
    if [ "0" != "$result" ]; then
        exit $result
    fi
}

function test_install {
    script=$1
    tag=$2
    path=$3

    echo "${PREFIX}Testing $script $tag"

    # Test local
    rm -f $PROJECT_PATH/test/$path/$script
    echo "${PREFIX}    bash install.sh $script $tag $path"
    output=$(bash $(dirname `pwd`)/bin/install.sh $script $tag $PROJECT_PATH/test/$path)
    result=$?
    if [ "0" != "$result" ] || [ "" == "$(echo "$output" | grep -i "installation succeeded")" ]; then
        echo $output
        exit $result
    fi
    test_script $script; result=$?; if [ "0" != "$result" ]; then exit $result; fi

    # Test cat
    rm -f $PROJECT_PATH/test/$path/$script
    echo "${PREFIX}    cat install.sh | bash -s $script $tag $path"
    output=$(cat $(dirname `pwd`)/bin/install.sh | bash -s $script $tag $PROJECT_PATH/test/$path)
    result=$?
    if [ "0" != "$result" ] || [ "" == "$(echo "$output" | grep -i "installation succeeded")" ]; then
        echo $output
        exit $result
    fi
    test_script $script; result=$?; if [ "0" != "$result" ]; then exit $result; fi

    # Test remote
    rm -f $PROJECT_PATH/test/$path/$script
    echo "${PREFIX}    curl install.sh | bash -s $script $tag $path"
    output=$(curl -f -L -s https://raw.githubusercontent.com/mkenney/docker-npm/$CURRENT_BRANCH/bin/install.sh | bash -s $script $tag $PROJECT_PATH/test/$path)
    result=$?
    if [ "0" != "$result" ] || [ "" == "$(echo "$output" | grep -i "installation succeeded")" ]; then
        echo $output
        exit $result
    fi
    test_script $script; result=$?; if [ "0" != "$result" ]; then exit $result; fi
}

test_install bower       $CURRENT_BRANCH $INSTALL_PATH; result=$?; if [ "0" != "$result" ]; then exit $result; fi
test_install generate-md $CURRENT_BRANCH $INSTALL_PATH; result=$?; if [ "0" != "$result" ]; then exit $result; fi
test_install grunt       $CURRENT_BRANCH $INSTALL_PATH; result=$?; if [ "0" != "$result" ]; then exit $result; fi
test_install gulp        $CURRENT_BRANCH $INSTALL_PATH; result=$?; if [ "0" != "$result" ]; then exit $result; fi
test_install node        $CURRENT_BRANCH $INSTALL_PATH; result=$?; if [ "0" != "$result" ]; then exit $result; fi
test_install npm         $CURRENT_BRANCH $INSTALL_PATH; result=$?; if [ "0" != "$result" ]; then exit $result; fi
test_install yarn        $CURRENT_BRANCH $INSTALL_PATH; result=$?; if [ "0" != "$result" ]; then exit $result; fi
