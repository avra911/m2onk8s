#Make script that builds and deploy the Magento files

SHELL := /bin/bash

# General method that checks for required environment variables. See http://stackoverflow.com/questions/4728810/makefile-variable-as-prerequisite
guard-env-%:
	@ if [ "${${*}}" == "" ]; then \
	    echo "---- ERROR ----"; \
	    echo "Environment variable $* not set"; \
	    echo "---------------"; \
	    exit 1; \
	fi

guard-cmd-%:
	$* -v > /dev/null 2>&1 ; \
	if [ ! $$? -eq 0 ]; then \
	    echo "Please verify the $* command line tool is installed and in your $PATH"; \
	fi

guard-changes:
	if [[ `git diff --shortstat 2> /dev/null | tail -n1` != "" ]]; then \
	    echo "---- ERROR ----"; \
            echo "There are unstaged changes present. Build unreliable"; \
	    echo "---------------" \
	    exit 1; \
	fi

deploy: guard-env-ENVIRONMENT
	echo "This is a stub method. It does nothing, yet"

# Infrastructure
create-infrastructure: guard-env-ENVIRONMENT guard-env-GOOGLE_CLOUD_PROJECT guard-env-GOOGLE_CLOUD_ZONE guard-env-gcloud
	gcloud container clusters create \
	    --project=$(GOOGLE_CLOUD_PROJECT) \
	    --enable-cloud-logging \
	    --machine-type=n1-standard-1 \
	    --num-nodes=2 \
	    --quiet \
	    --wait \
	    --zone=$(GOOGLE_CLOUD_ZONE) \
	    magento2-kubernetes

destroy-infrastructure: guard-env-GOOGLE_CLOUD_PROJECT guard-env-GOOGLE_CLOUD_ZONE guard-cmd-gcloud
	gcloud container clusters delete \
	    --project=$(GOOGLE_CLOUD_PROJECT) \
	    --quiet \
	    --wait \
	    magento2-kubernetes

build-application-web: guard-changes guard-cmd-composer
	# Implied that grunt exists. Jerk grunt returns a "99" status code with grunt -v.
	cd application && composer install --ignore-platform-reqs --optimize-autoloader --no-dev
	cd application && npm install
	cd application && grunt install

build-application-pod: guard-changes create-container-nginx create-container-php

build-application-nginx: guard-changes
	docker build -t magento2-kubernetes/nginx:$(git rev-parse --short HEAD) -f build/docker/NGINX/Dockerfile .

build-application--php:

make clean:
        
	# Delete application build
	rm -rf application/vendor
	rm -rf application/node_modules

	# Delete application cache
	rm -rf application/var/composer_home/
	rm -rf application/var/generation/
