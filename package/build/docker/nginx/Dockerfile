# NOTE: There is deliberately no PHP in this container. NGINX doesn't
# run PHP - It should have to have no knowledge of it, aside from
# which path to pass to the FastCGI Server. Magento makes the assumption
# the two will appear on the same HOST, but I don't like that as
# (in theory) security issues in NGINX could affect PHP, and you could
# accidentally misconfigure NGINX and dump your PHP source onto the
# interwebs.
FROM littlemanco/nginx:1.9.12-1
MAINTAINER <support@littleman.co>

# ADD bash script
ADD /build/docker/nginx/run.sh run.sh

# ADD Configuration
ADD /etc/nginx/site.conf /etc/nginx/sites-enabled/site.conf
ADD /build/artifacts/static.tar.gz /var/www/

# Media dir will be mounted on Google Cloud Storage
VOLUME ["/var/www/pub/media/", "/etc/ssl"]

# Remote the default server so it falls back on the new Magento one.
# Note:
#   Normally, this isn't a good thing. You'd want to drop traffic that
#   doesn't belong to a given vhost. But we're trying to make this as
#   easy as possible, and that means "wide open defaults".

RUN rm /etc/nginx/sites-enabled/default
CMD ./run.sh

EXPOSE 80
EXPOSE 443
