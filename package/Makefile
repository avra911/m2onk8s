#Make script that builds and deploy the Magento files

SHELL := /bin/bash

# General method that checks for required environment variables. See http://stackoverflow.com/questions/4728810/makefile-variable-as-prerequisite
guard-%:
	@ if [ "${${*}}" == "" ]; then \
	    echo "---- ERROR ----"; \
	    echo "Environment variable $* not set"; \
	    echo "---------------"; \
	    exit 1; \
	fi

guard-gcloud:
	gcloud -v > /dev/null 2>&1 ; \
	if [ ! $$? -eq 0 ]; then \
	    echo "Please verify the gcloud command line tool is installed and in your $PATH"; \
	fi

guard-changes:
	if [[ `git diff --shortstat 2> /dev/null | tail -n1` != "" ]]; then \
	    echo "---- ERROR ----"; \
            echo "There are unstaged changes present. Build unreliable"; \
	    echo "---------------" \
	    exit 1; \
	fi

deploy: guard-ENVIRONMENT
	echo "This is a stub method. It does nothing, yet"

# Infrastructure
create-infrastructure: guard-ENVIRONMENT guard-GOOGLE_CLOUD_PROJECT guard-GOOGLE_CLOUD_ZONE guard-gcloud
	gcloud container clusters create \
	    --project=$(GOOGLE_CLOUD_PROJECT) \
	    --enable-cloud-logging \
	    --machine-type=n1-standard-1 \
	    --num-nodes=2 \
	    --quiet \
	    --wait \
	    --zone=$(GOOGLE_CLOUD_ZONE) \
	    magento2-kubernetes

destroy-infrastructure: guard-GOOGLE_CLOUD_PROJECT guard-GOOGLE_CLOUD_ZONE guard-gcloud
	gcloud container clusters delete \
	    --project=$(GOOGLE_CLOUD_PROJECT) \
	    --quiet \
	    --wait \
	    magento2-kubernetes

create-pod: guard-change create-container-nginx create-container-php

create-container-nginx:
	mkdir build/docker/NGINX/tmp

	# I dislike having to copy files into the same DIR as the dockerfile. Still, it's the only way I know how this can be done.
	cp -r etc build/docker/NGINX/tmp/
	docker build -t magento2-kubernetes/nginx:$(git rev-parse --short HEAD) build/docker/NGINX

create-container-php:

make clean:
	rm -rf build/docker/NGINX/tmp

