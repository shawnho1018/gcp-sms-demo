#!/bin/bash
source envs.sh
# create pod
cat << EOF | kubectl apply -f -
apiVersion: v1
kind: ServiceAccount
metadata:
  name: mypodserviceaccount
  namespace: default
  annotations:
    iam.gke.io/gcp-service-account: gke-workload@$PROJECT_ID.iam.gserviceaccount.com
---
apiVersion: v1
kind: Pod
metadata:
  name: mypod
  namespace: default
spec:
  serviceAccountName: mypodserviceaccount
  containers:
  - image: gcr.io/google.com/cloudsdktool/cloud-sdk:slim
    imagePullPolicy: IfNotPresent
    name: mypod
    command: ['sleep', 'infinity']
    resources:
      requests:
        cpu: 100m
    volumeMounts:
      - mountPath: "/var/secrets"
        name: mysecret
    env:
    - name: GOOD_SECRET 
      valueFrom:
        secretKeyRef:
          name: good-secret
          key: pwd
  volumes:
  - name: mysecret
    csi:
      driver: secrets-store.csi.k8s.io
      readOnly: true
      volumeAttributes:
        secretProviderClass: "app-secrets"
EOF

