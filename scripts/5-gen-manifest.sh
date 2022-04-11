#!/usr/bin/env bash

set -euxo pipefail # see https://gist.github.com/mohanpedala/1e2ff5661761d3abd0385e8223e16425
ROOT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." >/dev/null 2>&1 && pwd )"
pushd "$ROOT_DIR" || { echo "could not change to root directory: $ROOT_DIR"; exit 1; }

IMG=$(< _IMG)

kubectl create deployment srv --image="$IMG" --dry-run=client -o yaml > deployment.yaml
kubectl create service clusterip srv --tcp=8080:8080 --dry-run=client -o yaml > service.yaml

kustomize build . -o final.yaml
