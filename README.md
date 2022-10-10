# Secret Manager Demo
There are 2 samples provided as examples to utilize GCP secret manager (GSM) as K8S secret. 
* The first method, gcp-sms-secret-provider, utilizes [secrets-store-csi-driver](https://secrets-store-csi-driver.sigs.k8s.io/topics/sync-as-kubernetes-secret.html) to convert GSM secret into k8s secret. 
* The second method, gcp-sms-ext-secret, utilizes [external-secret](https://external-secrets.io/v0.6.0/guides/getting-started/), to directly mount GSM secret into k8s secret.

It is recommended to utilize the first method since secrets-store-csi-driver was supported by GCP. 
