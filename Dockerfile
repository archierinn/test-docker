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
# Install composer
RUN apk add composer
# Copy custom configuration
COPY ./httpd.conf /etc/apache2/
COPY ./php.ini /etc/php7/
#d Download and install BoxBilling
RUN wget "https://github.com/boxbilling/boxbilling/releases/download/v4.22-beta.1/BoxBilling.zip"
RUN mkdir billing
RUN unzip -d ./billing BoxBilling.zip
RUN rm BoxBilling.zip
RUN mv billing/bb-config-sample.php billing/bb-config.php
RUN mv billing /var/www/localhost/htdocs
RUN chmod 755 /var/www/localhost/htdocs/billing
RUN chmod 777 /var/www/localhost/htdocs/billing/bb-config.php \
    /var/www/localhost/htdocs/billing/bb-data/cache \
    /var/www/localhost/htdocs/billing/bb-data/log \
    /var/www/localhost/htdocs/billing/bb-data/uploads
# Change Work directory to path
WORKDIR /var/www/localhost/htdocs/billing
# Listening to port 8004
EXPOSE 8004
# To avoid apache2 servername error
RUN echo "ServerName localhost" >> /etc/apache2/httpd.conf
CMD ["httpd", "-D","FOREGROUND"]