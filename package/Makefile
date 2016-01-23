#Make script that builds and deploy the Magento files

SHELL := /bin/bash
PROJECT_NS := m2onk8s
CONTAINER_NS := m2onk8s
GIT_HASH := $(shell git rev-parse --short HEAD)

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
create-infrastructure: guard-env-ENVIRONMENT guard-env-GOOGLE_CLOUD_PROJECT guard-env-GOOGLE_CLOUD_ZONE guard-cmd-gcloud
	gcloud container clusters create \
	    --project=$(GOOGLE_CLOUD_PROJECT) \
	    --enable-cloud-logging \
	    --machine-type=n1-standard-1 \
	    --num-nodes=2 \
	    --quiet \
	    --wait \
	    --zone=$(GOOGLE_CLOUD_ZONE) \
	    m2onk8s

destroy-infrastructure: guard-env-GOOGLE_CLOUD_PROJECT guard-env-GOOGLE_CLOUD_ZONE guard-cmd-gcloud
	gcloud container clusters delete \
	    --project=$(GOOGLE_CLOUD_PROJECT) \
	    --quiet \
	    --wait \
	    m2onk8s

build-application-web: guard-changes guard-cmd-composer
	# Implied that grunt exists. Jerk grunt returns a "99" status code with grunt -v.
	cd application && composer install --ignore-platform-reqs --optimize-autoloader --no-dev
	cd application && npm install
	cd application && grunt install

build-application-pod: guard-changes create-container-nginx create-container-php

build-application-php:
	# The code generation bit
	rm -rf application/var/di
	php application/bin/magento setup:di:compile
	
	# Interestingly, this bit doesn't work yet. Nor do I know what it does.
	# php application/bin/magento setup:di:compile-multi-tenant

	# The bit that allows the less compilation
	php application/bin/magento dev:source-theme:deploy

	# No idea. But it sounds important
	# Edit: It doesn't work. Needs arguments. But arguments about what!
	# php application/bin/magento setup:performance:generate-fixtures

	# The static content bit? I don't know. 
	php application/bin/magento setup:static-content:deploy
# Sending the build context to the docker daemon each time is going to get super annoying. It's like, 1.1gb 
# at the moment.
build-container-nginx: guard-env-GOOGLE_CLOUD_PROJECT
	docker build -t ${CONTAINER_NS}/nginx:${GIT_HASH} -f build/docker/NGINX/Dockerfile .
	docker tag ${CONTAINER_NS}/nginx:${GIT_HASH} gcr.io/$(GOOGLE_CLOUD_PROJECT)/nginx:${GIT_HASH}
	gcloud docker push gcr.io/$(GOOGLE_CLOUD_PROJECT)/nginx:${GIT_HASH}

build-container-php: guard-env-GOOGLE_CLOUD_PROJECT
	docker build -t ${CONTAINER_NS}/php:$(git rev-parse --short HEAD) -f build/docker/PHP/Dockerfile .
	docker tag ${CONTAINER_NS}/php:$(git rev-parse --short HEAD) gcr.io/$(GOOGLE_CLOUD_PROJECT)/php:${GIT_HASH}
	gcloud docker push gcr.io/$(GOOGLE_CLOUD_PROJECT)/php:${GIT_HASH}

install-application:
	# This should only be used in dev. If this Makefile hits prod, I'll be super unhappy with you (not really. But it's a bad idea)
	# Also, yes there are passwords below, yes I know it's never a good idea, but rest assured, they've never been used before or will be again.
	php application/bin/magento setup:install --db-host=127.0.0.1 --db-name=magento2 --db-user=root --db-password=my-secret-pw --admin-user="User" --admin-firstname=User --admin-lastname=atexampledotcom --admin-email=user@example.com --admin-password=10spaceship
	

make clean:
	# Delete application build
	rm -rf application/vendor
	rm -rf application/node_modules

	# Delete application cache
	rm -rf application/var/composer_home/
	rm -rf application/var/generation/
