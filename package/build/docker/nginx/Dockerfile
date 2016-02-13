# NOTE: There is deliberately no PHP in this container. NGINX doesn't 
# run PHP - It should have to have no knowledge of it, aside from 
# which path to pass to the FastCGI Server. Magento makes the assumption
# the two will appear on the same HOST, but I don't like that as 
# (in theory) security issues in NGINX could affect PHP, and you could 
# accidentally misconfigure NGINX and dump your PHP source onto the 
# interwebs.
FROM littlemanco/nginx:1.9.11-1
MAINTAINER <support@littleman.co>

# ADD Configuration
ADD etc/nginx/site.conf /etc/nginx/sites-enabled/site.conf

# Add static files (files in VCS)
ADD application/pub/errors/default/css     /var/www/pub/errors/default/css
ADD application/pub/errors/default/images  /var/www/pub/errors/default/images
ADD application/pub/static/                /var/www/pub/static
ADD application/pub/opt/                   /var/www/pub/opt

# Empty PHP File, as there's no PHP in this container.
ADD build/docker/nginx/index.php /var/www/pub/index.php

# Change the owner of all files to be www-dat
RUN chown -R www-data:www-data /var/www 

# Media dir will be mounted on Google Cloud Storage
VOLUME "/var/www/media/"

# Remote the default server so it falls back on the new Magento one. 
# Note: 
#  Normally, this isn't a good thing. You'd want to drop traffic that
#  doesn't belong to a given vhost. But we're trying to make this as 
#  easy as possible, and that means "wide open defaults".

RUN rm /etc/nginx/sites-enabled/default

EXPOSE 80
EXPOSE 443
