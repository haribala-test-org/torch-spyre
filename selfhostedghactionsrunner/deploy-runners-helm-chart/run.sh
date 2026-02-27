#!/usr/bin/env bash

# Chart values.yaml reference
# https://github.com/actions/actions-runner-controller/blob/master/charts/gha-runner-scale-set/values.yaml#L303

# INSTALLATION_NAME=self-hosted
# INSTALLATION_NAME="arc-runner-set-latest-image"
INSTALLATION_NAME="arc-runner-set-latest-image-1"
NAMESPACE="arc-runners"
GITHUB_CONFIG_URL=https://github.com/haribala-test-org/
GITHUB_PAT=xxxx
SECRET_NAME=hari-test-org-arc-runner-set-secret
# DRY_RUN="--dry-run"
DRY_RUN=""

oc project "${NAMESPACE}"
    # --set githubConfigSecret.github_token="${GITHUB_PAT}" \
helm install ${DRY_RUN} --debug "${INSTALLATION_NAME}" \
    --namespace "${NAMESPACE}" \
    -f values.yaml \
    -f arc-runner-set-latest-image-values.yaml \
    --set githubConfigUrl="${GITHUB_CONFIG_URL}" \
    --set githubConfigSecret="${SECRET_NAME}" \
    oci://ghcr.io/actions/actions-runner-controller-charts/gha-runner-scale-set


# NOTE: during dry run you might find an error like this:
# Error: INSTALLATION FAILED: execution error at (gha-runner-scale-set/templates/manager_role_binding.yaml:42:11): No gha-rs-controller deployment found using label (app.kubernetes.io/part-of=gha-rs-controller). Consider setting controllerServiceAccount.name in values.yaml to be explicit if you think the discovery is wrong.

# You can ignore it safely.
# It's because you are in 'arc-runners' namespace and the controller is running in the 'arc-systems'

# $ oc -n arc-systems get deployment -l 'app.kubernetes.io/part-of=gha-rs-controller'
# NAME                                                READY   UP-TO-DATE   AVAILABLE   AGE
# gha-runner-scale-set-controller-gha-rs-controller   1/1     1            1           9d
