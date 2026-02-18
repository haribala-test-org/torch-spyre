
## Usage

### Deploying Runners

1. Login to the AIU cluster

2. Modify the `values.yaml` file. In particular you need to set the token in the `secret.data` section.
You can get the token by going to your repo/org > settings > actions > click the "new runner" button

3. Deploy

```shell
helm install myrelease .
```

### Running Workflows

Just make a PR and it should run existing workflows like the linter.

You can add more workflows, see the docs https://docs.github.com/en/actions/reference/workflows-and-actions/workflow-syntax
