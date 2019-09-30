#!/bin/bash

# List of tests to execute
declare -a TESTS=()

# Don't add duplicates. Keep list sorted by test name.
add_tests() {
    echo "  Adding '$1' test suite..."
    case $1 in
        release)
            tests="1.build;install;bower;md;grunt;gulp;node;npm;npx;yarn"
            ;;
        node-alpine/*|node-debian/*|node-12-alpine/*|node-12-debian/*|node-11-alpine/*|node-11-debian/*|node-10-alpine/*|node-10-debian/*|node-9-alpine/*|node-9-debian/*|node-8-alpine/*|node-8-debian/*|node-7-alpine/*|node-7-debian/*|node-7.7-alpine/*|node-7.0-debian/*|node-6.9-alpine/*|node-6.9-debian/*|node-6-alpine/*|node-6-debian/*)
            tests="1.build"
            ;;
        .travis.yml)
            tests="install;bower;md;grunt;gulp;node;npm;npx;yarn"
            ;;
        bin/bower|test/resources/bower.json)
            tests="bower"
            ;;
        bin/generate-md|test/resources/md/index.md)
            tests="md"
            ;;
        bin/grunt|test/resources/Gruntfile.js)
            tests="grunt"
            ;;
        bin/gulp|test/resources/gulpfile.js)
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
        bin/npx)
            tests="npx"
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
