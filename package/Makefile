# Make script that builds and deploy the Magento files

# General method that checks for required environment variables. See http://stackoverflow.com/questions/4728810/makefile-variable-as-prerequisite
guard-%:
	@ if [ "${${*}}" == "" ]; then \
	    echo "---- ERROR ----"; \
	    echo "Environment variable $* not set"; \
	    echo "---------------"; \
	    exit 1; \
	fi

deploy: guard-ENVIRONMENT
	echo "This is a stub method. It does nothing, yet"

infrastructure: guard-ENVIRONMENT guard-GOOGLE_CLOUD_PROJECT guard-GOOGLE_CLOUD_ZONE
	gcloud -v >/dev/null 2>&1 ; \
	if [ ! $$? -eq 0 ] ; then \
	    echo "Please verify the gcloud command line tool is installed and working correctly"; \
	fi

	gcloud container clusters create \
	    --project=$(GOOGLE_CLOUD_PROJECT) \
	    --enable-cloud-logging \
	    --machine-type=n1-standard-1 \
	    --num-nodes=2 \
	    --quiet \
	    --wait \
	    --zone=asia-east1-a \
	    magento2-kubernetes
