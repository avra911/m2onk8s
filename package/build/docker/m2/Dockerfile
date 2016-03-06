# Dockerfile
FROM debian:8.3 
MAINTAINER littleman.co <support@littleman.co>

RUN echo "deb http://packages.dotdeb.org jessie all" >> /etc/apt/sources.list && \
    apt-get update && \
    apt-get upgrade -y && \ 
    apt-get install -y --force-yes \
        php7.0-fpm \
        php7.0-json \
        php7.0-opcache \
        php7.0-dev \
        php7.0-curl \
        php7.0-gd \
        php7.0-imagick \ 
        php7.0-intl \
        php7.0-mcrypt \
        php7.0-mysql \
        php7.0-xsl \
	php7.0-redis \
        git \
        build-essential && \ 
 
    # Clean up
    apt-get autoremove -y && \
    apt-get purge build-essential php7.0-dev git -y && \
    apt-get clean && \

# Note: 
# I'm not sure whether it's better to "edit in place" the
# existing, package provided configuration or whether
# it's better to just add an entire configuration file. 
# While the latter is (more) deterministic, the former
# is working well enough now, and I want to reduce the 
# maintenance burden 

# Update FPM pool options
    sed -i "s/listen = \/run\/php\/php7.0-fpm.sock/listen = 0.0.0.0:9000/" /etc/php/7.0/fpm/pool.d/www.conf && \
# Update global FPM options
    ## Run PHP in the foreground
    sed -i "s/;daemonize = yes/daemonize = no/" /etc/php/7.0/fpm/php-fpm.conf && \
    ## Move the PID into a folder that exists
    sed -i "s/\/run\/php\/php7.0-fpm.pid/\/run\/php7.0-fpm.pid/" /etc/php/7.0/fpm/php-fpm.conf && \
    ## Log everything to stdout, where it'll get picked up by docker / kubernetes && \
    sed -i "s/\/var\/log\/php7.0-fpm.log/\/proc\/self\/fd\/2/" /etc/php/7.0/fpm/php-fpm.conf && \

# Create the /var/www dir
    mkdir /var/www && \
    chown www-data:www-data /var/www 

VOLUME ["/etc/magento", "/var/www/media/"]
CMD php-fpm7.0

# Todo: Adding the entire dir is a disaster. Let's only add the things that we need to
#       It looks like this isn't possible with just the "Add" command. Might have to add 
#       a tarball that's been constructed (this might also solve some of the size issues
#       with chown? 

ADD {{PATH_PACKAGES}}/m2-{{GIT_HASH}}.tar.gz /var/www/
