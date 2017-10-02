#!/bin/bash bash

function deploy() {
    if [ "false" == "$TRAVIS" ]; then
        echo "Release builds can only be triggered within the CI environment, skipping for Dockerfile '$1'"

    elif [ "false" != "$TRAVIS_PULL_REQUEST" ]; then
        echo "Release builds cannot be triggered for pull requests, skipping for Dockerfile '$1'"

    else
        echo "Triggering release builds for Dockerfile '$1'"
        source $PROJECT_PATH/$1/.image-tags
        for tag in "${TAGS[@]}"; do
            echo "    - ${TAGS[tag]}"
            curl \
                -H "Content-Type: application/json" \
                --data "{\"docker_tag\": \"${TAGS[tag]}\"}" \
                -X POST \
                "https://registry.hub.docker.com/u/mkenney/npm/trigger/$DOCKER_TOKEN/"

            # Because Docker Hub throttles API calls a bit heavily
            sleep 30
        done
    fi
}