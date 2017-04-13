#!/bin/bash

INSTALL_PATH=bin
PREFIX="        "

# storage
mkdir -p $INSTALL_PATH
rm -f $INSTALL_PATH/*

function test_script {
    local script=$1

    # Test script
    output=$($script --version)
    result=$?
    echo "${PREFIX}        $script --version: $output"
    if [ "0" != "$result" ]; then
        exit $result
    fi
}

function test_install {
    local script=$1
    local tag=${2/master/latest}
    local path=$3

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
    test_script $PROJECT_PATH/test/$path/$script; result=$?; if [ "0" != "$result" ]; then exit $result; fi

    # Test cat
    rm -f $PROJECT_PATH/test/$path/$script
    echo "${PREFIX}    cat install.sh | bash -s $script $tag $path"
    output=$(cat $(dirname `pwd`)/bin/install.sh | bash -s $script $tag $PROJECT_PATH/test/$path)
    result=$?
    if [ "0" != "$result" ] || [ "" == "$(echo "$output" | grep -i "installation succeeded")" ]; then
        echo $output
        exit $result
    fi
    test_script $PROJECT_PATH/test/$path/$script; result=$?; if [ "0" != "$result" ]; then exit $result; fi

    # Test remote
    rm -f $PROJECT_PATH/test/$path/$script
    echo "${PREFIX}    curl install.sh | bash -s $script $tag $path"
    output=$(curl -f -L -s https://raw.githubusercontent.com/mkenney/docker-npm/$PARENT_BRANCH/bin/install.sh | bash -s $script $tag $PROJECT_PATH/test/$path)
    result=$?
    if [ "0" != "$result" ] || [ "" == "$(echo "$output" | grep -i "installation succeeded")" ]; then
        echo $output
        exit $result
    fi
    test_script $PROJECT_PATH/test/$path/$script; result=$?; if [ "0" != "$result" ]; then exit $result; fi
}

error_count=0
test_install bower       $PARENT_BRANCH $INSTALL_PATH; result=$?; if [ "0" != "$result" ]; then error_count=$error_count+1; fi
test_install generate-md $PARENT_BRANCH $INSTALL_PATH; result=$?; if [ "0" != "$result" ]; then error_count=$error_count+1; fi
test_install grunt       $PARENT_BRANCH $INSTALL_PATH; result=$?; if [ "0" != "$result" ]; then error_count=$error_count+1; fi
test_install gulp        $PARENT_BRANCH $INSTALL_PATH; result=$?; if [ "0" != "$result" ]; then error_count=$error_count+1; fi
test_install node        $PARENT_BRANCH $INSTALL_PATH; result=$?; if [ "0" != "$result" ]; then error_count=$error_count+1; fi
test_install npm         $PARENT_BRANCH $INSTALL_PATH; result=$?; if [ "0" != "$result" ]; then error_count=$error_count+1; fi
test_install yarn        $PARENT_BRANCH $INSTALL_PATH; result=$?; if [ "0" != "$result" ]; then error_count=$error_count+1; fi

echo
echo "errors: $error_count"
exit $error_count
