# Make script that builds and deploy the Magento files

# Variables
# ---------

SHELL := /bin/bash
PROJECT_NS := m2onk8s
CONTAINER_NS := m2onk8s
GIT_HASH := $(shell git rev-parse --short HEAD)

UID_WWW_DATA := 33
GID_WWW_DATA := 33

UID_OWNER    := $(shell id -u `whoami`)
GID_OWNER    := $(shell id -g `whoami`)

PATH_APPLICATION         := $(shell pwd)/application
PATH_BUILD_CONFIGURATION := $(shell pwd)/build
PATH_ARTIFACTS           := $(PATH_BUILD_CONFIGURATION)/artifacts

SECRET_MAGENTO    := $(shell base64 -w 0 build/secrets/.env)
SECRET_CERT       := $(shell base64 -w 0 build/secrets/cert.pem)
SECRET_FULL_CHAIN := $(shell base64 -w 0 build/secrets/fullchain.pem)
SECRET_PRIVKEY    := $(shell base64 -w 0 build/secrets/privkey.pem)

# Guards
# ------

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
# --------------

create-instances: guard-env-ENVIRONMENT guard-env-GOOGLE_CLOUD_PROJECT guard-env-GOOGLE_CLOUD_ZONE guard-cmd-gcloud
	gcloud container clusters create \
	    --project=$(GOOGLE_CLOUD_PROJECT) \
	    --enable-cloud-logging \
	    --machine-type=n1-standard-1 \
	    --num-nodes=2 \
	    --quiet \
	    --wait \
	    --zone=$(GOOGLE_CLOUD_ZONE) \
	    m2onk8s

create-sql: guard-env-GOOGLE_CLOUD_ZONE
	gcloud sql instances create \
	    --assign-ip \
	    --backup \
	    --require-ssl \
	    m2onk8s

create-infrastructure: create-instances create-sql

destroy-infrastructure: guard-env-GOOGLE_CLOUD_PROJECT guard-env-GOOGLE_CLOUD_ZONE guard-cmd-gcloud
	gcloud container clusters delete \
	    --project=$(GOOGLE_CLOUD_PROJECT) \
	    --quiet \
	    --wait \
	    m2onk8s

# Artifact Generation
# -------------------

pack-application:
	# Needs root to set user
	- sudo rm $(PATH_ARTIFACTS)/application.tar.gz
	cd $(PATH_APPLICATION) && \
	sudo tar -cvzf $(PATH_ARTIFACTS)/application.tar.gz ./* \
	    --owner=$(UID_WWW_DATA) \
	    --group=$(GID_WWW_DATA)

pack-static-assets:
	# Needs root to set user
	- sudo rm $(PATH_ARTIFACTS)/static.tar.gz
	cd $(PATH_APPLICATION) && \
	sudo tar -cvzf $(PATH_ARTIFACTS)/static.tar.gz pub \
	    --owner=1000 \
	    --group=1000

# Todo: merge with build-application-php, swap with "compile-application" - There's no web or other.
compile-application: guard-changes guard-cmd-composer
	# Implied that grunt exists. Jerk grunt returns a "99" status code with grunt -v.
	cd application && composer install --ignore-platform-reqs --optimize-autoloader --no-dev
	cd application && npm install
	cd application && grunt install

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
build-container-nginx: guard-env-GOOGLE_CLOUD_PROJECT pack-static-assets
	docker build -t ${CONTAINER_NS}/nginx:${GIT_HASH} -f build/docker/nginx/Dockerfile . 
	docker tag ${CONTAINER_NS}/nginx:${GIT_HASH} gcr.io/$(GOOGLE_CLOUD_PROJECT)/nginx:${GIT_HASH}
	gcloud docker push gcr.io/$(GOOGLE_CLOUD_PROJECT)/nginx:${GIT_HASH}

build-container-php: guard-env-GOOGLE_CLOUD_PROJECT
	# Unfortunately, as we're tar-ing the archive Docker doesn't seem to pick up filesystem changes, and invalidate the appropraite image
	# caches. So, we're never using one.
	sudo docker build --no-cache -t ${CONTAINER_NS}/php:${GIT_HASH} -f build/docker/php/Dockerfile $(PATH_BUILD_CONFIGURATION) 
	docker tag ${CONTAINER_NS}/php:${GIT_HASH} gcr.io/$(GOOGLE_CLOUD_PROJECT)/php:${GIT_HASH}
	gcloud docker push gcr.io/$(GOOGLE_CLOUD_PROJECT)/php:${GIT_HASH}

# Artifact deployment
# ---------------------

push-magento:
	sed "s/{{GIT_HASH}}/$(GIT_HASH)/" build/kubernetes/magento-rc.json | kubectl create -f -

push-nginx:
	sed "s/{{GIT_HASH}}/$(GIT_HASH)/" build/kubernetes/lb-rc.json | kubectl create -f -

push-secret-magento: 
	sed "s/{{BASE_64}}/$(SECRET_MAGENTO)/" build/kubernetes/magento-secret.json | kubectl replace -f - 

push-secret-nginx:
	sed "s/{{CERT}}/$(SECRET_CERT)/" build/kubernetes/nginx-secret.json | sed -e "s/{{FULL_CHAIN}}/$(SECRET_FULL_CHAIN)/" | sed -e "s/{{PRIVKEY}}/$(SECRET_PRIVKEY)/" | kubectl replace -f - 

# Development Tasks
# -----------------

mock-runtime-env:
	# This should only be used in dev. If this Makefile hits prod, I'll be super unhappy with you (not really. But it's a bad idea)
	# Also, yes there are passwords below, yes I know it's never a good idea, but rest assured, they've never been used before or will be again.
	docker run --name=mysql -e MYSQL_ROOT_PASSWORD=my-secret-pw -d -p 3306:3306  mysql/mysql-server:5.7 
	php application/bin/magento setup:install --db-host=127.0.0.1 --db-name=magento2 --db-user=root --db-password=my-secret-pw --admin-user="User" --admin-firstname=User --admin-lastname=atexampledotcom --admin-email=user@example.com --admin-password=10spaceship
clean:
	# Delete application build
	rm -rf application/vendor
	rm -rf application/node_modules

	# Delete application cache
	rm -rf application/var/composer_home/
	rm -rf application/var/generation/
