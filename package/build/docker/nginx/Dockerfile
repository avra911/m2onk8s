# NOTE: There is deliberately no PHP in this container. NGINX doesn't 
# run PHP - It should have to have no knowledge of it, aside from 
# which path to pass to the FastCGI Server. Magento makes the assumption
# the two will appear on the same HOST, but I don't like that as 
# (in theory) security issues in NGINX could affect PHP, and you could 
# accidentally misconfigure NGINX and dump your PHP source onto the 
# interwebs.
FROM littleman/nginx:latest
MAINTAINER <support@littleman.co>

# ADD Configuration
ADD etc/nginx/site.conf /etc/nginx/sites-enabled/site.conf

# Add static files (files in VCS)
ADD application/pub/errors/default/css     /var/www/pub/errors/default/css
ADD application/pub/errors/default/images  /var/www/pub/errors/default/images

# Empty PHP File, as there's no PHP in this container.
ADD build/nginx/php/index.php /var/www/pub/index.php

# Media dir will be mounted on Google Cloud Storage
VOLUME "/var/www/media/"

EXPOSE 80
EXPOSE 443
