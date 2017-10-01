#!/bin/bash

# List of tests to execute
declare -a TESTS=()

# Don't add duplicates. Keep list sorted by test name.
add_tests() {
    echo "  Adding '$1' test suite..."
    case $1 in
        release|test/1.build.sh|node-alpine/*|node-debian/*|node-8-alpine/*|node-8-debian/*|node-7-alpine/*|node-7.7-alpine/*|node-7.0-debian/*|node-6.9-alpine/*|node-6.9-debian/*)
            tests="1.build"
            RELEASE="false"
            if [ "release" == $1 ]; then
                RELEASE="true"
            fi
            export RELEASE
            ;;
        .travis.yml|test/run-tests.sh|test/lib/assert.sh|test/lib/travis.sh)
            tests="install;bower;md;grunt;gulp;node;npm;yarn"
            ;;
        bin/bower|test/bower.sh|test/resources/bower.json)
            tests="bower"
            ;;
        bin/generate-md|test/md.sh|test/resources/md/index.md)
            tests="md"
            ;;
        bin/grunt|test/grunt.sh|test/resources/Gruntfile.js)
            tests="grunt"
            ;;
        bin/gulp|test/gulp.sh|test/resources/gulpfile.js)
            tests="gulp"
            ;;
        bin/install.sh|test/install.sh)
            tests="install"
            ;;
        bin/node|test/node.sh|default)
            tests="node"
            ;;
        bin/npm|test/npm.sh)
            tests="npm"
            ;;
        bin/yarn|test/yarn.sh)
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
