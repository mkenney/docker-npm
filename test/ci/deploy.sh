#!/usr/bin/env sh

if [ "false" == "$TRAVIS" ]; then
    echo "Non-CI builds will not be triggered for tag '$1'"

elif [ "true" == "$TRAVIS_PULL_REQUEST" ]; then
    echo "Pull request builds will not be triggered for tag '$1'"

else
    echo "Triggering builds for tag '$1'"
    curl \
        -H "Content-Type: application/json" \
        --data "{\"docker_tag\": \"$1\"}"
        -X POST \
        https://registry.hub.docker.com/u/mkenney/npm/trigger/$DOCKER_TOKEN/
fi
