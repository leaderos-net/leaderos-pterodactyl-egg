FROM php:8.5-fpm

# Required Libs
RUN apt-get update && apt-get install -y --no-install-recommends \
    nginx \
    curl \
    wget \
    ca-certificates \
    git \
    tar \
    unzip \
    bash \
    fontconfig \
    imagemagick \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libwebp-dev \
    libzip-dev \
    libmagickwand-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg --with-webp \
    && docker-php-ext-install gd mysqli pdo pdo_mysql zip exif \
    && pecl install imagick \
    && docker-php-ext-enable imagick \
    && rm -rf /var/lib/apt/lists/*

# Ioncube Loader (PHP 8.5), loaded from php-fpm/php.ini
RUN ARCH="$(uname -m)" \
    && case "$ARCH" in \
        x86_64) IONCUBE_ARCH="x86-64" ;; \
        aarch64) IONCUBE_ARCH="aarch64" ;; \
        *) echo "Unsupported architecture: $ARCH" && exit 1 ;; \
    esac \
    && wget -q "https://downloads.ioncube.com/loader_downloads/ioncube_loaders_lin_${IONCUBE_ARCH}.tar.gz" \
    && tar -zxf "ioncube_loaders_lin_${IONCUBE_ARCH}.tar.gz" \
    && mkdir -p /usr/local/lib/ioncube \
    && cp ioncube/ioncube_loader_lin_8.5.so /usr/local/lib/ioncube/ \
    && rm -rf "ioncube_loaders_lin_${IONCUBE_ARCH}.tar.gz" ioncube

RUN useradd --create-home --home-dir /home/container container

USER container
ENV  USER=container HOME=/home/container

WORKDIR /home/container

COPY ./entrypoint.sh /entrypoint.sh

CMD ["/bin/bash", "/entrypoint.sh"]
