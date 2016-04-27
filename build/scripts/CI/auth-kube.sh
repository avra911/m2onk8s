#!/bin/bash

# Terminate on first failure
set -e

# Set in Travis
# GCR_REGION
# GCR_PROJECT
# KUBERNETS_CLUSTER

KUBE_NAMESPACE=sensu-littleman-co

# Auth Kube
gcloud container clusters get-credentials ${KUBERNETES_CLUSTER}

# Set the context for kube
export CONTEXT=$(kubectl config view | grep current-context | awk '{print $2}')
kubectl config set-context $CONTEXT --namespace=${KUBE_NAMESPACE}
