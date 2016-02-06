# Dockerfile
FROM littlemanco/phpfpm:7.0.2-2  
MAINTAINER littleman.co <support@littleman.co>

# Set redis as the session handler
RUN echo "session.save_handler = redis" >> /usr/local/etc/php.ini
RUN echo "session.save_path = tcp://redis.local:6379" >> /usr/local/etc/php.ini

RUN cat /usr/local/etc/php.ini | grep session 
RUN php-fpm -i | grep session

# Todo: Adding the entire dir is a disaster. Let's only add the things that we need to
ADD application /var/www/

# Todo: Sort out why these permissions are required (and why they're not working, even for root)
RUN chown -R www-data:www-data /var/www/
RUN chmod 777 /var/www/var/
RUN find /var/www/var/ -type d -exec chmod 777 {} \;

VOLUME ["/etc/magento"]
