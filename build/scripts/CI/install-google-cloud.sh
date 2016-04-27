#!/usr/bin/env bash

set -e

GOOGLE_CLOUD_VERSION=105.0.0

# Defined in Travis
# GCR_PROJECT
# GCR_REGION
# KUBERNETS_CLUSTER

# Need pyopenssl for gcloud, and need to install it via pip. See https://docs.travis-ci.com/user/languages/python
# Needs sudo to install pip
# Also needs additional libraries: http://urllib3.readthedocs.org/en/latest/security.html#openssl-pyopenssl
pip install --user --upgrade pyopenssl ndg-httpsclient pyasn1

# Install Google Cloud
wget "https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-${GOOGLE_CLOUD_VERSION}-linux-x86_64.tar.gz"
tar -xvf google-cloud-sdk-${GOOGLE_CLOUD_VERSION}-linux-x86_64.tar.gz

google-cloud-sdk/install.sh --additional-components core gcloud beta kubectl --quiet
