#!/usr/bin/env bash

IMAGE=us.icr.io/cil15-shared-registry/mytestghrunner:v4

docker buildx build . \
	-f Dockerfile \
	-t "${IMAGE}" \
	--platform linux/x86_64 \
	--load

docker push "${IMAGE}"
