# Dockerfile
FROM littlemanco/php-fpm:7.0.2-3 
MAINTAINER littleman.co <support@littleman.co>

# Add required PHP Extensions
RUN apt-get update && apt-get install -y php7.0-curl php7.0-gd php7.0-intl php7.0-mysql php7.0-xsl php7.0-mcrypt

# Todo: Adding the entire dir is a disaster. Let's only add the things that we need to
ADD application /var/www/

# Todo: Sort out why these permissions are required (and why they're not working, even for root)
RUN chown -R www-data:www-data /var/www/
RUN chmod 777 /var/www/var/
RUN find /var/www/var/ -type d -exec chmod 777 {} \;

VOLUME ["/etc/magento"]
