#!/bin/bash
source envs.sh

cat << EOF | kubectl apply -f -
apiVersion: kubernetes-client.io/v1
kind: ExternalSecret
metadata:
  name: my-gcp-secret #name of the External Secret and the generate k8s secret
spec:
  backendType: gcpSecretsManager
  projectId: ${PROJECT_ID}
  data:
    - key: testsecret # name of the GCP secret
      version: latest # version of the GCP secret
      name: secret-key # key name in the k8s secret
EOF
