#!/bin/bash

# Execute all the requested tests
execute_tests() {
    TEST_EXIT_CODE=0
    echo "
    Executing tests... ${TESTS[@]}"

    for test in "${!TESTS[@]}"; do
        echo "
    Executing test '${TESTS[test]}'..."
        if [ "1.build" == "${TESTS[test]}" ]; then
            bash $(dirname `pwd`)/test/1.build.sh
            result=$?
        else
            test_result=$(assert "${TESTS[test]}.sh" 0)
            result=$?
        fi
        if [ 0 -ne $result ]; then
            echo "failure (#$result)"
            TEST_EXIT_CODE=1
        else
            echo "
        success"
        fi
        if [ "-v" == "$1" ] || [ 0 -ne $result ] || [ "1.build" == "${TESTS[test]}" ]; then
            echo "
        $test_result"
            echo
        fi
    done
    exit $TEST_EXIT_CODE
}
