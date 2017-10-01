#!/bin/bash

# List of tests to execute
declare -a TESTS=()

# Don't add duplicates. Keep list sorted by test name.
add_tests() {
    echo "  Adding '$1' test suite..."
    case $1 in
        release|node-alpine/*|node-debian/*|node-8-alpine/*|node-8-debian/*|node-7-alpine/*|node-7.7-alpine/*|node-7.0-debian/*|node-6.9-alpine/*|node-6.9-debian/*)
            tests="1.build;install;bower;md;grunt;gulp;node;npm;yarn"
            RELEASE="false"
            if [ "release" == $1 ]; then
                RELEASE="true"
            fi
            export RELEASE
            ;;
        .travis.yml)
            tests="install;bower;md;grunt;gulp;node;npm;yarn"
            ;;
        bin/bower)
            tests="bower"
            ;;
        bin/generate-md)
            tests="md"
            ;;
        bin/grunt)
            tests="grunt"
            ;;
        bin/gulp)
            tests="gulp"
            ;;
        bin/install.sh)
            tests="install"
            ;;
        bin/node)
            tests="node"
            ;;
        bin/npm)
            tests="npm"
            ;;
        bin/yarn)
            tests="yarn"
            ;;
        test/resources/package.json)
            tests="npm;yarn"
            ;;
    esac

    set -f
    array=(${tests//;/ })
    for new_test in "${!array[@]}"; do
        echo "    - '${array[new_test]}'"
        is_current_test=0
        for current_test in "${!TESTS[@]}"; do
            if [ "${TESTS[current_test]}" == "${array[new_test]}" ]; then
                is_current_test=1
            fi
        done
        if [ 0 -eq $is_current_test ]; then
            TESTS+=("${array[new_test]}")
        fi
    done
    echo

    # Sort
    TESTS=(
        $(for a in "${TESTS[@]}"
        do
            echo "$a"
        done | sort)
    )
}
