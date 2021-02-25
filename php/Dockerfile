FROM alpine:latest
# Install Apache + PHP
RUN apk add openrc sed curl apache2 php7-apache2
RUN apk add --update-cache \
    php7 \
    php7-pdo_mysql \
    php7-curl \
    php7-mbstring \
    php7-zlib \
    php7-ftp \
    php7-gettext \
    php7-mcrypt \ 
    php7-openssl \
    php7-ctype \
    php7-json \
    php7-session
# Install composer + git
RUN apk add composer git
# Copy custom configuration
COPY ./php/httpd.conf /etc/apache2/
COPY ./php.ini /etc/php7/
#d Download and install BoxBilling
RUN git clone "https://github.com/archierinn/test-php.git"
RUN mv test-php /var/www/localhost/htdocs
RUN chmod 755 /var/www/localhost/htdocs/test-php
# Change Work directory to path
WORKDIR /var/www/localhost/htdocs/test-php
# Listening to port 8004
EXPOSE 80
# To avoid apache2 servername error
RUN echo "ServerName localhost" >> /etc/apache2/httpd.conf
CMD ["httpd", "-D","FOREGROUND"]