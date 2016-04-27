#!/bin/bash

set -e

# Decrypt the tar file
openssl aes-256-cbc -K $encrypted_7cf163de18a9_key -iv $encrypted_7cf163de18a9_iv -in .secrets.tar.gz.enc -out .secrets.tar.gz -d

# Unpack the file
tar -xvf .secrets.tar.gz
