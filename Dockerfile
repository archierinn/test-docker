FROM alpine:latest
RUN apk add --no-cache add \
    curl \
    nginx \
    php7 \
    php7-pdo_mysql \
    php7-curl \
    php7-mbstring \
    php7-zlib \
    php7-ftp \
    php7-gettext \
    php7-mcrypt \
    php7-openssl

COPY ./default.conf /etc/nginx/conf.d/
#COPY ./billing /etc/nginx/sites-available/
#RUN ln -s /etc/nginx/sites-available/billing /etc/nginx/sites-enabled/
COPY ./php.ini /etc/php7/
RUN mkdir -p /var/www/billing
WORKDIR /var/www/billing
RUN wget "https://github.com/boxbilling/boxbilling/releases/download/v4.22-beta.1/BoxBilling.zip"
RUN unzip BoxBilling.zip
RUN chmod 777 bb-data/cache
EXPOSE 8004
CMD ["nginx", "-g", "daemon off;"]