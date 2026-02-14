
# To bring up a new runner

1. Bring up the pod with pod.yaml

```shell
oc create -f pod.yaml
```

1. Go to https://github.com/haribala-test-org/torch-spyre/settings/actions/runners

2. Click "add runner" and it will give you a command like this with a token

```shell
./config.sh --url https://github.com/haribala-test-org/torch-spyre --token AE7TWWxxxxx
```

1. Go inside the pod and run the above command

```shell
oc exec -it <pod name> bash
```

1. Accept all the default settings

2. To start the GitHub actions runner in the background. NOTE: Can't use `./svc.sh` because it requires sudo/root user

```shell
nohup ./run.sh &
```
