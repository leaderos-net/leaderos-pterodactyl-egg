FROM php:7.4-fpm-alpine

RUN apk add --no-cache --update \
    curl \
    ca-certificates \
    openssl \
    git \
    tar \
    bash \
    sqlite \
    fontconfig \
    oniguruma-dev \
    libzip-dev \
    curl-dev

RUN docker-php-ext-install pdo pdo_mysql mbstring json zip curl fileinfo

RUN adduser --disabled-password --home /home/container container

USER container
ENV  USER=container HOME=/home/container

WORKDIR /home/container

COPY ./entrypoint.sh /entrypoint.sh

CMD ["/bin/bash", "/entrypoint.sh"]
