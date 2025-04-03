# 🐳 PHP 7.4 + Symfony CLI + Firebase (gRPC) Docker Image

This Docker image provides a ready-to-use PHP 7.4 FPM environment with:

- PHP 7.4 FPM
- Composer 2.0.7
- Symfony CLI
- Firebase SDK (gRPC)
- Useful PHP extensions: `bcmath`, `pdo_mysql`, `pdo_pgsql`, `gd`, `zip`, `exif`

---

📦 **Available on Docker Hub**:  
👉 [https://hub.docker.com/r/ouakeds/symfony-firebase](https://hub.docker.com/r/ouakeds/symfony-firebase)

---

## 🛠️ Installed Tools & Extensions

- **PHP 7.4-FPM**
- **Composer v2.0.7**
- **Symfony CLI**
- **gRPC extension** for Firebase
- **PHP Extensions**:
  - bcmath
  - pdo_mysql
  - pdo_pgsql
  - gd (with JPEG, PNG, Freetype)
  - zip
  - exif

---

## 🚀 How to Use

### Pull the image

```bash
docker pull ouakeds/symfony-firebase
```

### Run a container

```bash
docker run -it --rm ouakeds/symfony-firebase bash
```

Inside the container, you'll be able to use:

```bash
php -v
composer --version
symfony -v
```

---

## 📁 Dockerfile Overview

```Dockerfile
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

# Install Symfony CLI
RUN curl -sS https://get.symfony.com/cli/installer | bash
RUN mv /root/.symfony/bin/symfony /usr/local/bin/symfony

# Install Firebase dependencies (gRPC)
RUN pecl install grpc
RUN echo extension=grpc.so >> /usr/local/etc/php/php.ini

# Optional: verify PHP config
RUN php --ini
```

---

## 👨‍💻 Author

Image published by [ouakeds](https://hub.docker.com/u/ouakeds)

Feel free to contribute, suggest improvements, or fork the image for your own use.
