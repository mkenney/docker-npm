#!/bin/bash

INSTALL_PATH=bin
PREFIX="        "

# storage
mkdir -p $INSTALL_PATH
rm -f $INSTALL_PATH/*

function test_script {
    local script=$1

    # Test script
    output=$(DOCKER_NPM_TAG=latest $script --version)
    result=$?
    echo "${PREFIX}        $script --version: $output"
    if [ "0" != "$result" ]; then
        exit $result
    fi
}

function test_install {
    local script=$1
    local path=$2

    echo "${PREFIX}Testing $script"

    # Test local
    rm -f $PROJECT_PATH/test/$path/$script
    echo "${PREFIX}    bash install.sh $script $path"
    output=$(bash $(dirname `pwd`)/bin/install.sh $script $PROJECT_PATH/test/$path)
    result=$?
    if [ "0" != "$result" ] || [ "" == "$(echo "$output" | grep -i "installation succeeded")" ]; then
        echo $output
        exit $result
    fi
    test_script $PROJECT_PATH/test/$path/$script; result=$?; if [ "0" != "$result" ]; then exit $result; fi

    # Test cat
    rm -f $PROJECT_PATH/test/$path/$script
    echo "${PREFIX}    cat install.sh | bash -s $script $path"
    output=$(cat $(dirname `pwd`)/bin/install.sh | bash -s $script $PROJECT_PATH/test/$path)
    result=$?
    if [ "0" != "$result" ] || [ "" == "$(echo "$output" | grep -i "installation succeeded")" ]; then
        echo $output
        exit $result
    fi
    test_script $PROJECT_PATH/test/$path/$script; result=$?; if [ "0" != "$result" ]; then exit $result; fi

    # Test remote
    rm -f $PROJECT_PATH/test/$path/$script
    echo "${PREFIX}    curl install.sh | bash -s $script $path"
    output=$(curl -f -L -s https://raw.githubusercontent.com/mkenney/docker-npm/master/bin/install.sh | bash -s $script $PROJECT_PATH/test/$path)
    result=$?
    if [ "0" != "$result" ] || [ "" == "$(echo "$output" | grep -i "installation succeeded")" ]; then
        echo $output
        exit $result
    fi
    test_script $PROJECT_PATH/test/$path/$script; result=$?; if [ "0" != "$result" ]; then exit $result; fi
}

error_count=0
test_install bower       $INSTALL_PATH; result=$?; if [ "0" != "$result" ]; then error_count=$error_count+1; fi
test_install generate-md $INSTALL_PATH; result=$?; if [ "0" != "$result" ]; then error_count=$error_count+1; fi
test_install grunt       $INSTALL_PATH; result=$?; if [ "0" != "$result" ]; then error_count=$error_count+1; fi
test_install gulp        $INSTALL_PATH; result=$?; if [ "0" != "$result" ]; then error_count=$error_count+1; fi
test_install node        $INSTALL_PATH; result=$?; if [ "0" != "$result" ]; then error_count=$error_count+1; fi
test_install npm         $INSTALL_PATH; result=$?; if [ "0" != "$result" ]; then error_count=$error_count+1; fi
test_install yarn        $INSTALL_PATH; result=$?; if [ "0" != "$result" ]; then error_count=$error_count+1; fi

echo
echo "errors: $error_count"
exit $error_count
