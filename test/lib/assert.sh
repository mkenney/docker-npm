#!/bin/bash

function assert {
    script=$1

    expected=0

    if [ "" != "$2" ]; then
        expected=$2
    fi

    #
echo bash $(dirname `pwd`)/test/$script
exit 1
    bash $(dirname `pwd`)/test/$script
    result=$?
    echo "        expected: $expected, result: $result"
    exit $result
}