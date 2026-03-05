
DRY_RUN ?= 
# DRY_RUN ?= "--dry-run"
K8S_CLI ?= oc
K8S_OPERATOR_NAMESPACE ?= arc-systems
K8S_NAMESPACE ?= arc-runners
GITHUB_CONFIG_URL ?= https://github.com/torch-spyre/
# INSTALLATION_NAME ?= official-torch-spyre-org-arc-runner-set
INSTALLATION_NAME ?= official-aiu-x86-64-arc-runner-set
K8S_SECRET_NAME ?= ${INSTALLATION_NAME}-secret
# RUNNER_SET_PRIVATE_KEY_PEM ?= official-torch-spyre-github-app-private.pem
# GITHUB_APP_ID ?= 2356116
# GITHUB_APP_INSTALLATION_ID ?= 96555807
RUNNER_SET_PRIVATE_KEY_PEM ?= spyre-ci.2026-03-05.private-key.pem
GITHUB_APP_ID ?= 3013805
GITHUB_APP_INSTALLATION_ID ?= 114181434

ECHO_DELIM ?= ----------------------------------

.PHONY: switch-namespace
switch-namespace:
	@echo "${ECHO_DELIM}"
	${K8S_CLI} project ${K8S_NAMESPACE} || exit 1
	@echo "${ECHO_DELIM}"

.PHONY: info
info: switch-namespace
	${K8S_CLI} get pods -n ${K8S_OPERATOR_NAMESPACE}
	@echo "${ECHO_DELIM}"
	${K8S_CLI} get pods -n ${K8S_NAMESPACE}
	@echo "${ECHO_DELIM}"
	${K8S_CLI} get secrets -n ${K8S_NAMESPACE}
	@echo "${ECHO_DELIM}"
	${K8S_CLI} get autoscalingrunnersets.actions.github.com -n ${K8S_NAMESPACE}
	@echo "${ECHO_DELIM}"
	helm ls -n ${K8S_NAMESPACE}
	@echo "${ECHO_DELIM}"

.PHONY: create-k8s-secret
create-k8s-secret: switch-namespace
	${K8S_CLI} create secret generic "${K8S_SECRET_NAME}" \
		--namespace="${K8S_NAMESPACE}" \
		--from-literal="github_app_id=${GITHUB_APP_ID}" \
		--from-literal="github_app_installation_id=${GITHUB_APP_INSTALLATION_ID}" \
		--from-file="github_app_private_key=${RUNNER_SET_PRIVATE_KEY_PEM}"

.PHONY: delete-k8s-secret
delete-k8s-secret:
	${K8S_CLI} delete secret "${K8S_SECRET_NAME}" -n ${K8S_NAMESPACE}

.PHONY: deploy-runner-set
deploy-runner-set: switch-namespace
	helm install ${DRY_RUN} --debug "${INSTALLATION_NAME}" \
		--namespace "${K8S_NAMESPACE}" \
		-f values.yaml \
		-f arc-runner-set-latest-image-values.yaml \
		--set githubConfigUrl="${GITHUB_CONFIG_URL}" \
		--set githubConfigSecret="${K8S_SECRET_NAME}" \
		oci://ghcr.io/actions/actions-runner-controller-charts/gha-runner-scale-set

.PHONY: undeploy-runner-set
undeploy-runner-set: switch-namespace
	helm uninstall --namespace "${K8S_NAMESPACE}" "${INSTALLATION_NAME}"
	${K8S_CLI} delete secret "${K8S_SECRET_NAME}" -n ${K8S_NAMESPACE}

.PHONY: deploy
deploy: create-k8s-secret deploy-runner-set

.PHONY: undeploy
undeploy: undeploy-runner-set delete-k8s-secret
