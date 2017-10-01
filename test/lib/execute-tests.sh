#!/bin/bash

# Execute all the requested tests
execute_tests() {
    TEST_EXIT_CODE=0
    echo "
    Executing tests... $TESTS"

    if [ "1.build" == "${TESTS[0]}" ]; then
        echo "
    Executing test 'build'..."
        test_result=
        bash 1.build.sh
        result=$?
        if [ 0 -ne $result ]; then
            echo "failure (#$result)"
            TEST_EXIT_CODE=1
        else
            echo "success"
        fi
    else
        for test in "${!TESTS[@]}"; do
        echo "
    Executing test '$test'..."
            test_result=$(assert "${TESTS[test]}.sh" 0)
            result=$?
            if [ 0 -ne $result ]; then
                echo "failure (#$result)"
                TEST_EXIT_CODE=1
            else
                echo "success"
            fi
            if [ "-v" == "$1" ] || [ 0 -ne $result ] || [ "1.build" == "${TESTS[test]}" ]; then
                echo "$test_result"
                echo
            fi
        done
    fi
    exit $TEST_EXIT_CODE
}
