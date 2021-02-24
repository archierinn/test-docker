FROM alpine:latest
# install Apache + PHP
#RUN echo $'\n\
#http://dl-cdn.alpinelinux.org/alpine/v"$(cat /etc/alpine-release | cut -d'.' -f1,2)"/main \
#http://dl-cdn.alpinelinux.org/alpine/v"$(cat /etc/alpine-release | cut -d'.' -f1,2)"/community' >> /etc/apk/repositories

RUN apk update
RUN export phpverx=$(alpinever=$(cat /etc/alpine-release|cut -d '.' -f1);[ $alpinever -ge 9 ] && echo  7|| echo 5)
RUN apk add apache2 php$phpverx-apache2
RUN apk add openrc
#ADD https://dl.bintray.com/php-alpine/key/php-alpine.rsa.pub /etc/apk/keys/php-alpine.rsa.pub
#RUN apk --update-cache add ca-certificates && \
#    echo "https://dl.bintray.com/php-alpine/v3.11/php-7.4" >> /etc/apk/repositories
# install php and some extensions
RUN apk add --update-cache \
#    php \
    php7-pdo_mysql \
    php7-curl \
    php7-zlib \
    php7-gettext \
    php7-openssl
# install mysql
#RUN apk add mysql mysql-client
# install Git
#RUN apk add git unzip
# install GCC
#RUN apk add build-base
# install composer
# RUN apk add composer
# install Boxbilling
RUN wget "https://github.com/boxbilling/boxbilling/releases/download/v4.22-beta.1/BoxBilling.zip"
RUN mkdir boxbilling
RUN unzip -d ./boxbilling BoxBilling.zip
RUN mv boxbilling /var/www/localhost/htdocs
#RUN cd /var/www/localhost/htdocs/boxbilling
# RUN composer install
# run apache server
#RUN rc-service apache2 start
EXPOSE 8004
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf
CMD ["httpd", "-D","FOREGROUND"]