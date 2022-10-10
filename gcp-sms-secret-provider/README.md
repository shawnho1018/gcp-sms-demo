# Secrets-Store-CSI-Provider
* Create a GKE standard cluster and get its kubeconfig.
* Run 0_setup-key.sh. This script would: 
  1. Create a testsecret in GCP secret manager.
  2. Create a GCP IAM account and assign roles/secretmanager.secretAccessor role. 
  3. Set up a workload identity to link it to K8S service account, mypodserviceaccount in default namespace.
* Run 1_create-secretproviderclass.sh. This script would add a k8s secret, good-secret, with a key: "pwd" ,in addition to the [regular GCP SecretProviderClass](https://raw.githubusercontent.com/GoogleCloudPlatform/secrets-store-csi-driver-provider-gcp/main/examples/app-secrets.yaml.tmpl).
```
  secretObjects:
  - secretName: good-secret
    type: Opaque
    data:
    - objectName: good1.txt
      key: pwd
```
Expected Result:
```
kubectl get secrets
NAME                                     TYPE                                  DATA   AGE
default-token-sqxlf                      kubernetes.io/service-account-token   3      28h
good-secret                              Opaque                                1      3h27m
my-gcp-secret                            Opaque                                1      52m
mypodserviceaccount-token-vkmpk          kubernetes.io/service-account-token   3      4h17m
sh.helm.release.v1.external-secrets.v1   helm.sh/release.v1                    1      52m
```

* Run 2_create-pod.sh. This script would create a pod, which directly utilize k8s secret, good-secret, as environment varaible. Use kubectl exec to find the environment variables and the expected result is:
```
kubectl exec -it mypod -- /bin/sh -c export
export CLOUD_SDK_VERSION='405.0.0'
export GOOD_SECRET='mysecret
'
export HOME='/root'
export HOSTNAME='mypod'
export KUBERNETES_PORT='tcp://10.48.0.1:443'
export KUBERNETES_PORT_443_TCP='tcp://10.48.0.1:443'
export KUBERNETES_PORT_443_TCP_ADDR='10.48.0.1'
export KUBERNETES_PORT_443_TCP_PORT='443'
export KUBERNETES_PORT_443_TCP_PROTO='tcp'
export KUBERNETES_SERVICE_HOST='10.48.0.1'
export KUBERNETES_SERVICE_PORT='443'
export KUBERNETES_SERVICE_PORT_HTTPS='443'
export PATH='/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/opt/google-cloud-sdk/bin/'
export PWD='/'
export TERM='xterm'
```
