#!/bin/bash

function assert {

exit 0

    script=$1

    expected=0
    if [ "" != "$2" ]; then
        expected=$2
    fi

    #
    bash $(dirname `pwd`)/test/$script;
    result=$?
    echo "        expected: $expected, result: $result"
    exit $result
}