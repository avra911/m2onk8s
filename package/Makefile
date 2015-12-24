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

infrastructure: guard-ENVIRONMENT
	echo "Hello"
