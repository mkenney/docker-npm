#!/usr/bin/env sh

if [ "false" == "$TRAVIS" ]; then
    echo "Non-CI builds will not be triggered for the '$1' Dockerfile"

elif [ "true" == "$TRAVIS_PULL_REQUEST" ]; then
    echo "Pull request builds will not be triggered the '$1' Dockerfile"

else
    echo "Triggering builds for the '$1' Dockerfile"
    source $PROJECT_PATH/$1/.image-tags
    for tag in "${TAGS[@]}"; do
        curl \
            -H "Content-Type: application/json" \
            --data "{\"docker_tag\": \"$tag\"}"
            -X POST \
            https://registry.hub.docker.com/u/mkenney/npm/trigger/$DOCKER_TOKEN/

        # Because Docker Hub throttles API calls a bit heavily
        sleep 60
    done
fi
