FROM alpine:3.15

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
    curl-dev \
    php7 \
    php7-fpm \
    php7-mysqli \
    php7-json \
    php7-mbstring \
    php7-curl \
    php7-xml \
    php7-zip \
    php7-openssl \
    php7-pdo \
    php7-pdo_mysql \
    php7-session \
    php7-fileinfo \
    nginx

RUN adduser --disabled-password --home /home/container container

USER container
ENV  USER=container HOME=/home/container

WORKDIR /home/container

COPY ./entrypoint.sh /entrypoint.sh

CMD ["/bin/bash", "/entrypoint.sh"]
