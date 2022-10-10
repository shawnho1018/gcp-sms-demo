#!/bin/bash
source envs.sh

# create secret provider class
cat << EOF | kubectl apply -f -
apiVersion: secrets-store.csi.x-k8s.io/v1
kind: SecretProviderClass
metadata:
  name: app-secrets
spec:
  provider: gcp
  parameters:
    secrets: |
      - resourceName: "projects/$PROJECT_ID/secrets/testsecret/versions/latest"
        path: "good1.txt"
      - resourceName: "projects/$PROJECT_ID/secrets/testsecret/versions/latest"
        path: "good2.txt"
  secretObjects:
  - secretName: good-secret
    type: Opaque
    data:
    - objectName: good1.txt
      key: pwd
EOF
