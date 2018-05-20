#!/bin/bash

# Execute all the requested tests
export TEST_EXIT_CODE=0
function execute_tests() {
    echo "
    Executing tests... ${TESTS[@]}"

    for test in "${!TESTS[@]}"; do
        echo "
    Executing test '${TESTS[test]}'..."
        test_result=$(assert "${TESTS[test]}.sh" 0)
        result=$?

        echo "
        $test_result"
        echo

        if [ 0 -ne $result ]; then
            echo "failure (#$result)"
            TEST_EXIT_CODE=1
        else
            echo "
        success"
        fi

    done
}
