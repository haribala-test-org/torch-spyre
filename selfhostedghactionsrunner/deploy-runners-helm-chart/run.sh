#!/usr/bin/env bash

# Chart values.yaml reference
# https://github.com/actions/actions-runner-controller/blob/master/charts/gha-runner-scale-set/values.yaml#L303

# INSTALLATION_NAME=self-hosted
INSTALLATION_NAME="arc-runner-set-latest-image"
NAMESPACE="arc-runners"
GITHUB_CONFIG_URL=https://github.com/haribala-test-org/
GITHUB_PAT=xxxx

# helm install --dry-run --debug "${INSTALLATION_NAME}" \
helm install --debug "${INSTALLATION_NAME}" \
    --namespace "${NAMESPACE}" \
    -f values.yaml \
    -f arc-runner-set-latest-image-values.yaml \
    --set githubConfigUrl="${GITHUB_CONFIG_URL}" \
    --set githubConfigSecret.github_token="${GITHUB_PAT}" \
    oci://ghcr.io/actions/actions-runner-controller-charts/gha-runner-scale-set
