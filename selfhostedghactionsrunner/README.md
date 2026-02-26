
## Usage

### Deploying Runners

```shell
cd deploy-runners-helm-chart/
```

1. Login to the AIU cluster https://console-openshift-console.apps.torch-cicd.spyre.res.ibm.com/k8s/ns/torch-spyre-cicd/core~v1~Pod

1. Modify the `run.sh file` (and if you really want also the `arc-runner-set-latest-image-values.yaml` file)
   - You should change the installation name to a new name for the runner set.
   - You should change the repo/org to watch `GITHUB_CONFIG_URL=https://github.com/haribala-test-org/`
   - (Option 1) You can set the token in the `GITHUB_PAT=xxxx` line.
   - (Option 1) You can get the PAT by going to your profile -> create a classic token -> give repo and admin org roles. Use the `--set githubConfigSecret.github_token="${GITHUB_PAT}"`
   - (Option 1) https://docs.github.com/en/actions/tutorials/use-actions-runner-controller/authenticate-to-the-api#deploying-using-personal-access-token-classic-authentication
   - (Option 2) You can create and use a GitHub app (instead of the classic token)
   - (Option 2) https://docs.github.com/en/actions/tutorials/use-actions-runner-controller/authenticate-to-the-api#authenticating-arc-with-a-github-app
   - (Option 2) After you create a K8s secret, use the `--set githubConfigSecret="${SECRET_NAME}"`

1. Deploy the new runner set.

```shell
./run.sh
```

On a successful deployment you should see

```shell
$ ./run.sh
Already on project "arc-runners" on server "https://api.torch-cicd.spyre.res.ibm.com:6443".
level=DEBUG msg="Original chart version" version=""
level=DEBUG msg="set up default downloader cache"

........
........
........

Thank you for installing gha-runner-scale-set.

Your release is named arc-runner-set-latest-image-1.

$ echo $?
0

$ helm ls
NAME                            NAMESPACE   REVISION    UPDATED                                 STATUS      CHART                       APP VERSION
...........
arc-runner-set-latest-image-1   arc-runners 1           2026-02-26 20:20:47.740067 +0530 IST    deployed    gha-runner-scale-set-0.13.1 0.13.1
```

The runner set should show up in your org https://github.com/organizations/haribala-test-org/settings/actions/runners

### Running Workflows

Just make a PR and it should run existing workflows like the linter.

You can add more workflows, see the docs https://docs.github.com/en/actions/reference/workflows-and-actions/workflow-syntax
