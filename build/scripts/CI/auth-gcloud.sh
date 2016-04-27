#!/bin/bash

# Terminate on first failure
set -e

# Set in Travis
# - GCR_REGION
# - GCR_PROJECT
# - KUBERNETS_CLUSTER
# - GCR_SERVICE_ACCOUNT

# Auth Gcloud
gcloud auth activate-service-account ${GCR_SERVICE_ACCOUNT} --key-file .gcloud.json
gcloud config set project ${GCR_PROJECT}
gcloud config set compute/zone ${GCR_REGION}
gcloud config set container/cluster ${KUBERNETES_CLUSTER}
