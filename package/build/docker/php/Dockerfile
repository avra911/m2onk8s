# Dockerfile
FROM littlemanco/php-fpm:7.0.2-2dev 
MAINTAINER littleman.co <support@littleman.co>

ADD application /var/www/
RUN chown -R www-data:www-data /var/www/
RUN chmod 777 /var/www/var/
RUN find /var/www/var/ -type d -exec chmod 777 {} \;
