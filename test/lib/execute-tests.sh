#!/bin/bash

# Execute all the requested tests
function execute_tests() {
    echo "
    Executing tests... ${TESTS[@]}"

    for test in "${!TESTS[@]}"; do
        echo "
    Executing test '${TESTS[test]}'..."
        bash $(dirname `pwd`)/test/${TESTS[test]}.sh
        result=$?
        if [ 0 -ne $result ]; then
            echo "failure (#$result)"
            exit 1
        else
            echo "
        success"
        fi
    done
}
