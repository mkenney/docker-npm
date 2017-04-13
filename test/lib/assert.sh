#!/bin/bash

function assert {
echo "start assert"

    script=$1

    expected=0
echo "pre-error"
    if [ -z $2 ]; then
        expected=$2
    fi
echo "post-error"
echo "script: $(dirname `pwd`)/test/$script"

    #
    bash $(dirname `pwd`)/test/$script;
    result=$?
echo "result: $result"
    echo "        expected: $expected, result: $result"

echo "end assert"
    exit $result
}