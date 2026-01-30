#!/bin/bash

SCRIPTPATH="$(dirname "$0")"

REGISTRY="sgtcoder"
PROJECT_NAME="sail"
PROJECT_TAGS=("8.3" "8.4")
PROJECT_LATEST="8.3"

for PROJECT_TAG in "${PROJECT_TAGS[@]}"; do
    echo "Building and pushing $REGISTRY/$PROJECT_NAME:$PROJECT_TAG..."

    cd $SCRIPTPATH/runtimes/$PROJECT_TAG

    if [ "$PROJECT_TAG" = "$PROJECT_LATEST" ]; then
        docker buildx build --push --platform linux/amd64,linux/arm64 --build-arg WWWGROUP=1000 $1 -t $REGISTRY/$PROJECT_NAME:$PROJECT_TAG -t $REGISTRY/$PROJECT_NAME:latest . || exit 1
    else
        docker buildx build --push --platform linux/amd64,linux/arm64 --build-arg WWWGROUP=1000 $1 -t $REGISTRY/$PROJECT_NAME:$PROJECT_TAG . || exit 1
    fi
done

#docker push --all-tags $REGISTRY/$PROJECT_NAME
