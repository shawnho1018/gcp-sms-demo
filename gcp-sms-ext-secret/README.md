# External Secret
This example utilizes another OSS project, [external-secret](https://github.com/boredabdel/gke-secret-manager/tree/main/hello-secret-external-secrets). This project depends on gcp-sms-secret-provider to produce GSA, KSA, and secret in GCP secret manager. Please first produce those before running the scripts in this folder. 

There are two scripts in this folder. The first is to install external-secrets using helm chart. K8S service account and gcp-service-account were required as installation parameters. The second one uses backendType: gcpSecretsManager to convert GCP secrets into k8s secret. The name in ExternalSecret would be used as k8s secret name. spec.data.key and spec.data.version are the secret name and version in GCP secret manager. spec.data.name is the key value in k8s secret name. The expected result looks like:
```
kubectl get secrets
NAME                                     TYPE                                  DATA   AGE
default-token-sqxlf                      kubernetes.io/service-account-token   3      28h
my-gcp-secret                            Opaque                                1      52m
sh.helm.release.v1.external-secrets.v1   helm.sh/release.v1                    1      52m
---
kubectl describe secret my-gcp-secret
Name:         my-gcp-secret
Namespace:    default
Labels:       <none>
Annotations:  <none>

Type:  Opaque

Data
====
secret-key:  9 bytes
```
