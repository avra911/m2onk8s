# Dockerfile
FROM littlemanco/phpfpm:7.0.3-2 
MAINTAINER littleman.co <support@littleman.co>

# Set redis as the session handler
RUN echo "session.save_handler = redis" >> /usr/local/etc/php.ini && \
    echo "session.save_path = tcp://redis.local:6379" >> /usr/local/etc/php.ini && \
    cat /usr/local/etc/php.ini | grep session && \
    php-fpm -i | grep session

# Todo: Adding the entire dir is a disaster. Let's only add the things that we need to
ADD application /var/www/

VOLUME ["/etc/magento"]
