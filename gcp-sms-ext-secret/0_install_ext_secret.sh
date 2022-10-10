#!/bin/bash
source envs.sh
helm repo add external-secrets https://external-secrets.github.io/kubernetes-external-secrets/
helm install external-secrets external-secrets/kubernetes-external-secrets \
    --set serviceAccount.annotations."iam\.gke\.io/gcp-service-account"='gke-workload@'"${PROJECT_ID}"'.iam.gserviceaccount.com' \
    --set serviceAccount.create=false \
    --set serviceAccount.name="mypodserviceaccount"
