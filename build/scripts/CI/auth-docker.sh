#!/bin/bash

# Terminate on first failure
set -e

# Auth Docker
docker login -e ${GCR_SERVICE_ACCOUNT} -u _token -p "$(gcloud auth print-access-token)" https://gcr.io
