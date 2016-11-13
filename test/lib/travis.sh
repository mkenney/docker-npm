if [ "true" != "$TRAVIS" ]; then
    # assume dev testing

    # Get the current and parent branch names
    # based on https://gist.github.com/intel352/9761288#gistcomment-1774649
    vbc_col=$(( $(git show-branch | grep '^[^\[]*\*' | head -1 | cut -d* -f1 | wc -c) - 1 ))
    swimming_lane_start_row=$(( $(git show-branch | grep -n "^[\-]*$" | cut -d: -f1) + 1 ))
    TRAVIS_BRANCH=`git show-branch | tail -n +$swimming_lane_start_row | grep -v "^[^\[]*\[$CURRENT_BRANCH" | grep "^.\{$vbc_col\}[^ ]" | head -n1 | sed 's/.*\[\(.*\)\].*/\1/' | sed 's/[\^~].*//'`
    if [ "" == "$TRAVIS_BRANCH" ]; then TRAVIS_BRANCH=master; fi
    export TRAVIS_BRANCH

    export TRAVIS=false
    export TRAVIS_PULL_REQUEST=false
fi

if [ "false" == "$TRAVIS_PULL_REQUEST" ]; then
    export TRAVIS_PULL_REQUEST_BRANCH=`git rev-parse --abbrev-ref HEAD`
fi

export CURRENT_BRANCH=$TRAVIS_PULL_REQUEST_BRANCH
export PARENT_BRANCH=$TRAVIS_BRANCH
