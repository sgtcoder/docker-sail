#!/usr/bin/env bash
set -e

SCRIPTPATH="$(cd "$(dirname "$0")" && pwd)"
SRC="$SCRIPTPATH"
REGISTRY="sgtcoder"
PROJECT_NAME="sail"
PROJECT_TAGS=("8.3" "8.4")
PROJECT_LATEST="8.3"

cli_log "INFO" "Building and pushing images..."
for dir in "${PROJECT_TAGS[@]}"; do
    cli_log "INFO" "Building $REGISTRY/$PROJECT_NAME:$dir..."

    if [ "$dir" = "$PROJECT_LATEST" ]; then
        docker buildx build --push --platform linux/amd64,linux/arm64 --build-arg WWWGROUP=1000 "$@" -f "$SRC/runtimes/$dir/Dockerfile" -t "$REGISTRY/$PROJECT_NAME:$dir" -t "$REGISTRY/$PROJECT_NAME:latest" "$SRC/runtimes/$dir"
    else
        docker buildx build --push --platform linux/amd64,linux/arm64 --build-arg WWWGROUP=1000 "$@" -f "$SRC/runtimes/$dir/Dockerfile" -t "$REGISTRY/$PROJECT_NAME:$dir" "$SRC/runtimes/$dir"
    fi
done

cli_log "SUCCESS" "Completed successfully" "border"
