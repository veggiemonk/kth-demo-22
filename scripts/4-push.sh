#!/usr/bin/env bash

set -euxo pipefail # see https://gist.github.com/mohanpedala/1e2ff5661761d3abd0385e8223e16425
ROOT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." >/dev/null 2>&1 && pwd )"
pushd "$ROOT_DIR" || { echo "could not change to root directory: $ROOT_DIR"; exit 1; }

# SHORT_SHA=$(git rev-parse --short HEAD)
# DATE=$(date +"%y%m%d")
# TAG="$DATE-$SHORT_SHA"
# IMG="gcr.io/$GOOGLE_CLOUD_PROJECT/srv:$TAG"
# TAG=$(docker images --format '{{.Tag}}' | grep $SHORT_SHA)

IMG=$(< _IMG)

docker push "$IMG"
