# Make script that builds and deploy the Magento files

# Make configuration
# ------------------
.PHONY: help

# Variables
# ---------

.DEFAULT_GOAL := help
SHELL         := /bin/bash

PROJECT_NS := m2onk8s
CONTAINER_NS := m2onk8s
GIT_HASH := $(shell git rev-parse --short HEAD)

ANSI_TITLE        := '\e[1;32m'
ANSI_CMD          := '\e[0;32m'
ANSI_TITLE        := '\e[0;33m'
ANSI_SUBTITLE     := '\e[0;37m'
ANSI_WARNING      := '\e[1;31m'
ANSI_OFF          := '\e[0m'

UID_WWW_DATA := 33
GID_WWW_DATA := 33

UID_OWNER    := $(shell id -u `whoami`)
GID_OWNER    := $(shell id -g `whoami`)

PATH_APPLICATION         := $(shell pwd)/application
PATH_BUILD_CONFIGURATION := $(shell pwd)/build
PATH_ARTIFACTS           := $(PATH_BUILD_CONFIGURATION)/artifacts
PATH_PACKAGES            := $(PATH_BUILD_CONFIGURATION)/packages

SECRET_CERT       := $(shell base64 -w 0 build/secrets/cert.pem)
SECRET_FULL_CHAIN := $(shell base64 -w 0 build/secrets/fullchain.pem)
SECRET_PRIVKEY    := $(shell base64 -w 0 build/secrets/privkey.pem)

# Help
# ----

help: ## Show this menu
	@echo -e $(ANSI_TITLE)m2onk8s$(ANSI_OFF)$(ANSI_SUBTITLE) - An experiment running Magento 2 on Kubernetes \(with Google Cloud\)$(ANSI_OFF)
	@echo -e "\n"$(ANSI_WARNING)Warning:$(ANSI_OFF) "This is not yet production ready. It probably doesn't even work! When it hits a release, you're OK.\n"
	@echo -e $(ANSI_TITLE)Requirements:$(ANSI_OFF)
	@echo -e "    "$(ANSI_TITLE)Binaries:$(ANSI_OFF) bash docker gcloud git kubectl tar"\n"
	@echo -e $(ANSI_TITLE)Application Structures:$(ANSI_OFF)" (See README.rst for definitions)"
	@echo -e "    lb m2\n"
	@echo -e $(ANSI_TITLE)Commands:$(ANSI_OFF)
	@grep -E '^[a-zA-Z _-%]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "    \033[32m%-30s\033[0m %s\n", $$1, $$2}'

# Artifact Generation
# -------------------

pack-application: ## Packs the application in a .tar.gz file for consumption by the Docker daemon
	# Needs root to set user
	test ! -f $(PATH_PACKAGES)/m2-$(GIT_HASH).tar.gz && \
	cd $(PATH_APPLICATION) && \
	sudo tar -cvzf $(PATH_PACKAGES)/m2-$(GIT_HASH).tar.gz ./* \
	    --owner=$(UID_WWW_DATA) \
	    --group=$(GID_WWW_DATA)

# Artifact deployment
# ---------------------

prov-secret-magento: ## Pushes an update to the Magento secret to Kubernetes
	- kubectl delete secret magento-credentials
	sed "s/{{BASE_64}}/$(SECRET_MAGENTO)/" build/kubernetes/magento-secret.json | kubectl create -f -

prov-secret-lb: ## Pushes an update to the NGINX secret to Kubernetes
	# Delete the previous resource if it exists
	- kubectl delete secret ssl-certificates
	sed "s/{{CERT}}/$(SECRET_CERT)/" build/kubernetes/lb-secret.json | sed -e "s/{{FULL_CHAIN}}/$(SECRET_FULL_CHAIN)/" | sed -e "s/{{PRIVKEY}}/$(SECRET_PRIVKEY)/" | kubectl create -f -

clean: clean-packages clean-docker clean-application-generation clean-application-packages ## Delete everything so you can start again

clean-application-packages: ## Delete all of the vendor depependences
	# Delete application build
	rm -rf application/vendor
	rm -rf application/node_modules

clean-application-generation: ## Delete all of Magento 2's "Generated Code"
	rm -rf application/var/composer_home/
	rm -rf application/var/generation/

clean-packages: ## Delete all the application packages for docker
	rm build/artifacts/*.tar.gz

clean-docker: ## Delete the generated Dockerfile
	rm Dockerfile

# Application Compilation
# -----------------------

compile-application: ## Installs all of the depenencies reqired with the various package managers
	# Implied that grunt exists. Jerk grunt returns a "99" status code with grunt -v.
	cd application && composer install --ignore-platform-reqs --optimize-autoloader --no-dev
	cd application && npm install
	cd application && grunt install

	# The code generation bit
	- rm -rf application/var/di
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
