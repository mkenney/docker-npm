#!/bin/bash
function list_changes() {
    grep_str=".*"
    if [ "" != "$1" ]; then
        grep_str="$1"
    fi

    if [ "" != "$CURRENT_BRANCH" ]; then
        git diff --name-only master | grep "$grep_str"
    else
        git --no-pager diff --name-only FETCH_HEAD $(git merge-base FETCH_HEAD master)
    fi
}