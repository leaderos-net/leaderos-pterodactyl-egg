FROM php:7.4-fpm

# Install dependencies
RUN apt-get update && apt-get install -y \
    curl \
    zip \
    libzip-dev \
    libcurl4 \
    libcurl4-openssl-dev \
    libonig-dev \
    default-mysql-client \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libxml2-dev

# Install nginx
RUN apt-get install -y nginx

# Clear cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Install extensions
RUN docker-php-ext-install pdo pdo_mysql mbstring zip curl json fileinfo

USER container
ENV  USER container
ENV HOME /home/container

WORKDIR /home/container
COPY ./entrypoint.sh /entrypoint.sh


CMD ["/bin/sh", "/entrypoint.sh"]
