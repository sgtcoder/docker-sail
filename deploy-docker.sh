#!/bin/bash

REGISTRY="sgtcoder"
PROJECT_NAME="sail"
PROJECT_TAG="8.3"

#./deploy-docker.sh --no-cache

cd runtimes/$PROJECT_TAG

docker build --build-arg WWWGROUP=1000 $1 -t $REGISTRY/$PROJECT_NAME:$PROJECT_TAG . || exit 1

docker push $REGISTRY/$PROJECT_NAME:$PROJECT_TAG
