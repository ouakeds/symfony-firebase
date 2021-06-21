FROM php:7.4-fpm

# Install dependencies
RUN apt-get update && apt-get install -y \
        git zip unzip libpq-dev libzip-dev libpng-dev libfreetype6-dev libjpeg62-turbo-dev \
    && docker-php-ext-install -j$(nproc) bcmath pdo_mysql pdo_pgsql gd zip exif \
    && apt-get clean && apt-get autoclean

# Install composer
ENV COMPOSER_VERSION 2.0.7

RUN curl -sS https://getcomposer.org/download/$COMPOSER_VERSION/composer.phar -o /usr/local/bin/composer \
    && chmod +x /usr/local/bin/composer

# Install symfony
RUN curl -sS https://get.symfony.com/cli/installer | bash
RUN export PATH="$HOME/.symfony/bin:$PATH"
RUN echo /usr/local/etc/php/php.ini-development php.ini

# Install Firebase dependencies
RUN pecl install grpc
RUN echo extension=grpc.so >> /usr/local/etc/php/php.ini

# Actualize package
RUN php --ini

# Install symfony cli
RUN curl -sS https://get.symfony.com/cli/installer | bash
RUN mv /root/.symfony/bin/symfony /usr/local/bin/symfony

# Copy current repository inside image