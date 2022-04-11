#!/usr/bin/env bash

set -euxo pipefail # see https://gist.github.com/mohanpedala/1e2ff5661761d3abd0385e8223e16425
ROOT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." >/dev/null 2>&1 && pwd )"
pushd "$ROOT_DIR" || { echo "could not change to root directory: $ROOT_DIR"; exit 1; }

IP=$(kubectl get svc srv -o json | jq '.spec.clusterIP')
set +x
echo 
echo 
echo wget -qO- "http://$IP:8080/test/kth/demo"
echo 
echo 
set -x

kubectl run busybox --rm --image=busybox -it --restart=Never -- sh
