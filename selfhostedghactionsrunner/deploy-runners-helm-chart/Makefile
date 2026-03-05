
DRY_RUN ?= 
# DRY_RUN ?= "--dry-run"
K8S_CLI ?= oc
GITHUB_CONFIG_URL ?= https://github.com/torch-spyre/
INSTALLATION_NAME ?= official-torch-spyre-org-arc-runner-set
K8S_SECRET_NAME ?= ${INSTALLATION_NAME}-secret
RUNNER_SET_PRIVATE_KEY_PEM ?= official-torch-spyre-github-app-private.pem
K8S_NAMESPACE ?= arc-runners
GITHUB_APP_ID ?= 2356116
GITHUB_APP_INSTALLATION_ID ?= 96555807


.PHONY: create-k8s-secret
create-k8s-secret:
	${K8S_CLI} project ${K8S_NAMESPACE} || exit 1
	${K8S_CLI} create secret generic "${K8S_SECRET_NAME}" \
		--namespace="${K8S_NAMESPACE}" \
		--from-literal="github_app_id=${GITHUB_APP_ID}" \
		--from-literal="github_app_installation_id=${GITHUB_APP_INSTALLATION_ID}" \
		--from-file="username=${RUNNER_SET_PRIVATE_KEY_PEM}"

.PHONY: deploy-runner-set
deploy-runner-set:
	${K8S_CLI} project ${K8S_NAMESPACE} || exit 1
	helm install ${DRY_RUN} --debug "${INSTALLATION_NAME}" \
		--namespace "${K8S_NAMESPACE}" \
		-f values.yaml \
		-f arc-runner-set-latest-image-values.yaml \
		--set githubConfigUrl="${GITHUB_CONFIG_URL}" \
		--set githubConfigSecret="${K8S_SECRET_NAME}" \
		oci://ghcr.io/actions/actions-runner-controller-charts/gha-runner-scale-set
