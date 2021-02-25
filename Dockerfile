FROM alpine:latest
# install Apache + PHP
#RUN echo $'\n\
#http://dl-cdn.alpinelinux.org/alpine/v"$(cat /etc/alpine-release | cut -d'.' -f1,2)"/main \
#http://dl-cdn.alpinelinux.org/alpine/v"$(cat /etc/alpine-release | cut -d'.' -f1,2)"/community' >> /etc/apk/repositories
RUN apk update
RUN apk add openrc sed curl
RUN export phpverx=$(alpinever=$(cat /etc/alpine-release|cut -d '.' -f1);[ $alpinever -ge 9 ] && echo  7|| echo 5)
RUN apk add apache2 php$phpverx-apache2
#RUN sed -i 's/^Listen 80$/Listen 0.0.0.0:8004/' /etc/apache2/httpd.conf
#ADD https://dl.bintray.com/php-alpine/key/php-alpine.rsa.pub /etc/apk/keys/php-alpine.rsa.pub
#RUN apk --update-cache add ca-certificates && \
#    echo "https://dl.bintray.com/php-alpine/v3.11/php-7.4" >> /etc/apk/repositories
# install php and some extensions
RUN apk add --update-cache \
#    php \
    php7-pdo_mysql \
    php7-curl \
    php7-mbstring \
    php7-zlib \
    php7-ftp \
    php7-gettext \
    php7-mcrypt
# install IonCube 
RUN apk add --no-cache php7-imap && \
  mkdir -p setup && cd setup && \
  curl -sSL https://downloads.ioncube.com/loader_downloads/ioncube_loaders_lin_x86-64.tar.gz -o ioncube.tar.gz && \
  tar -xf ioncube.tar.gz && \
  mv ioncube/ioncube_loader_lin_7.2.so /usr/lib/php7/modules/ && \
  echo 'zend_extension = /usr/lib/php7/modules/ioncube_loader_lin_7.2.so' >  /etc/php7/conf.d/00-ioncube.ini && \
  cd .. && rm -rf setup
# install mysql
#RUN apk add mysql mysql-client
# install Git
#RUN apk add git unzip
# install GCC
#RUN apk add build-base
# install composer
# RUN apk add composer
# install Boxbilling
COPY ./httpd.conf /etc/apache2/
COPY ./php.ini /etc/php7/
#RUN rc-service apache2 restart
#RUN cd /var/www/localhost/htdocs
#RUN mkdir billing
#RUN chmod 777 billing
#RUN cd billing
#RUN wget "https://github.com/boxbilling/boxbilling/releases/download/v4.22-beta.1/BoxBilling.zip"
#RUN unzip BoxBilling.zip
RUN wget "https://github.com/boxbilling/boxbilling/releases/download/v4.22-beta.1/BoxBilling.zip"
RUN mkdir billing
RUN unzip -d ./billing BoxBilling.zip
#RUN mv bb-config-sample.php bb-config.php
#RUN find . -type d -exec chmod 755 {} \;
#RUN find . -type f -exec chmod 644 {} \;
RUN mv billing /var/www/localhost/htdocs
RUN chmod 777 /var/www/localhost/htdocs/billing/bb-data/cache
#RUN cd /var/www/localhost/htdocs/boxbilling
# RUN composer install
# run apache server
EXPOSE 8004
RUN echo "ServerName localhost" >> /etc/apache2/httpd.conf
#WORKDIR /var/www/localhost/htdocs/boxbilling
#RUN cp /etc/apache2/mods-available/rewrite.load /etc/apache2/mods-enabled/
#RUN a2enmod rewrite
#RUN rc-service apache2 start
CMD ["httpd", "-D","FOREGROUND"]