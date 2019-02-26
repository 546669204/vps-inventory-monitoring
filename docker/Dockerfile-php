FROM php:7.2-fpm

#ADD ./docker/crontab /etc/cron.d

RUN apt-get update \
&& apt-get install -y \
libfreetype6-dev \
libjpeg62-turbo-dev \
libpng-dev \
&& docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
&& docker-php-ext-install -j$(nproc) gd \
&& docker-php-ext-install pdo \
&& docker-php-ext-install pdo_mysql



