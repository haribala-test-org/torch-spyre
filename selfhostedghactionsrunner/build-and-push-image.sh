#!/usr/bin/env bash

IMAGE=us.icr.io/cil15-shared-registry/aiu-gha-runner:v1

docker buildx build . \
    -f Dockerfile \
    -t "${IMAGE}" \
    --platform linux/x86_64 \
    --load

docker push "${IMAGE}"

# docker run --rm -it --platform linux/amd64 "${IMAGE}"
