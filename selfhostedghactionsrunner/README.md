
## Usage

### Deploying Runners

```shell
cd deploy-runners-helm-chart/
```

1. Login to the AIU cluster

1. Modify the `values.yaml` and the `run.sh file`. You should change the installation name to a new name for the runner set.
In particular you need to set the token in the `GITHUB_PAT=xxxx` line.
You can get the PAT by going to your profile -> create a classic token -> give repo and admin org roles
    See:
   - https://docs.github.com/en/actions/tutorials/use-actions-runner-controller/authenticate-to-the-api#deploying-using-personal-access-token-classic-authentication
   - https://docs.github.com/en/actions/tutorials/use-actions-runner-controller/authenticate-to-the-api#deploying-using-personal-access-token-classic-authentication

1. Deploy the new runner set.

```shell
./run.sh
```

### Running Workflows

Just make a PR and it should run existing workflows like the linter.

You can add more workflows, see the docs https://docs.github.com/en/actions/reference/workflows-and-actions/workflow-syntax
