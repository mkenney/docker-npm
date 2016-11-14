#!/bin/bash

export PROJECT_PATH=$(dirname `pwd`)


# Test execution method
source $PROJECT_PATH/test/lib/travis.sh
source $PROJECT_PATH/test/lib/assert.sh

# List of tests to execute
declare -a TESTS=()

get_test_suite() {
    case $1 in
        Dockerfile|test/build.sh|release)
            echo "build;install;bower;md;grunt;gulp;node;npm;yarn"
            ;;
        .travis.yml|test/run-tests.sh|test/lib/assert.sh|test/lib/travis.sh)
            echo "install;bower;md;grunt;gulp;node;npm;yarn"
            ;;
        bin/bower|test/bower.sh|test/resources/bower.json)
            echo "bower"
            ;;
        bin/generate-md|test/md.sh|test/resources/md/index.md)
            echo "md"
            ;;
        bin/grunt|test/grunt.sh|test/resources/Gruntfile.js)
            echo "grunt"
            ;;
        bin/gulp|test/gulp.sh|test/resources/gulpfile.js)
            echo "gulp"
            ;;
        bin/install.sh|test/install.sh)
            echo "install"
            ;;
        bin/node|test/node.sh|default)
            echo "node"
            ;;
        bin/npm|test/npm.sh)
            echo "npm"
            ;;
        bin/yarn|test/yarn.sh)
            echo "yarn"
            ;;
        test/resources/package.json)
            echo "npm;yarn"
            ;;
    esac
}

verbose=
if [ "-v" == "$1" ]; then
    verbose=-v
    shift
fi

#
# Add a test to the current list of tests to be executed
# Don't add duplicates. Keep list sorted by test name.
#
add_test() {
    echo "  Adding '$1' test suite..."
    tests=$(get_test_suite $1)

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

#
# Execute all the requested tests
# Don't add duplicates. Keep list sorted by test name.
#
exit_code=0
execute_tests() {
    echo "
  Executing tests..."
    for test in "${!TESTS[@]}"; do
        printf "    - ${TESTS[test]}... "
        if [ "build" == "${TESTS[test]}" ]; then
            test_result=
            bash "${TESTS[test]}.sh"
        else
            test_result=$(assert "${TESTS[test]}.sh" 0)
        fi
        result=$?
        if [ 0 -ne $result ]; then
            echo "failure (#$result)"
            exit_code=1
        else
            echo "success"
        fi
        if [ "-v" == "$1" ] || [ 0 -ne $result ] || [ "build" == "${TESTS[test]}" ]; then
            echo "$test_result"
            echo
        fi
    done
}
sh ./node.sh > /dev/null 2>&1 # This should make it pull

#
#
#
echo "
Analyzing changes: $CURRENT_BRANCH <=> $PARENT_BRANCH
"

run_tests=
if [ "" != "$1" ]; then
    add_test $1
else
    test_found=0
    for file in $(git diff --name-only HEAD^); do
        add_test $file
        test_found=1
    done
fi
if [ "$CURRENT_BRANCH" == "$PARENT_BRANCH" ] || [ "0" == "$test_found" ]; then
    add_test release
fi

execute_tests $verbose

echo "
  bower --version:       $($PROJECT_PATH/bin/bower --version)
  generate-md --version: $($PROJECT_PATH/bin/generate-md --version)
  grunt --version:       $($PROJECT_PATH/bin/grunt --version)
  gulp --version:        $($PROJECT_PATH/bin/gulp --version)
  node --version:        $($PROJECT_PATH/bin/node --version)
  npm --version:         $($PROJECT_PATH/bin/npm --version)
  yarn --version:        $($PROJECT_PATH/bin/yarn --version)
"
exit $exit_code
