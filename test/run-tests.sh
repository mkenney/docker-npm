#!/bin/bash

export PROJECT_PATH=$(dirname `pwd`)


# Test execution methods
source $PROJECT_PATH/test/lib/add-tests.sh
source $PROJECT_PATH/test/lib/assert.sh
source $PROJECT_PATH/test/lib/deploy.sh
source $PROJECT_PATH/test/lib/execute-tests.sh
source $PROJECT_PATH/test/lib/list-changes.sh
source $PROJECT_PATH/test/lib/travis.sh

verbose=
if [ "-v" == "$1" ]; then
    verbose=-v
    shift
fi

#sh ./node.sh > /dev/null 2>&1 # This should make it pull

echo "
Analyzing changes: $CURRENT_BRANCH <=> $PARENT_BRANCH
"

run_tests=
if [ "" != "$1" ]; then
    add_tests $1
else
    test_found=0
    for file in $(list_changes); do
        add_tests $file
        test_found=1
    done
fi

if [ "true" == "$TRAVIS" ]; then
    if [ "$CURRENT_BRANCH" == "$PARENT_BRANCH" ] || [ "0" == "$test_found" ] || [ "false" == $TRAVIS_PULL_REQUEST ]; then
        add_tests release
    fi
fi

execute_tests $verbose
exit_code=$TEST_EXIT_CODE

echo "
  bower --version:       $($PROJECT_PATH/bin/bower --version)
  generate-md --version: $($PROJECT_PATH/bin/generate-md --version)
  grunt --version:       $($PROJECT_PATH/bin/grunt --version)
  gulp --version:        $($PROJECT_PATH/bin/gulp --version)
  node --version:        $($PROJECT_PATH/bin/node --version)
  npm --version:         $($PROJECT_PATH/bin/npm --version)
  yarn --version:        $($PROJECT_PATH/bin/yarn --version)
"

for dockerfile in $(list_changes Dockerfile); do
    if [ -f $PROJECT_PATH/$dockerfile ]; then
        echo "    ...$(deploy $(dirname $dockerfile))"
    fi
done

exit $exit_code
