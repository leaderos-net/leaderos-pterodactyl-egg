FROM ubuntu:22.04

RUN apt update -y
RUN apt install -y curl ca-certificates openssl zip unzip git
RUN apt install -y nginx
RUN apt install -y software-properties-common
RUN add-apt-repository ppa:ondrej/php -y
RUN apt update -y
RUN apt install php7.4 php7.4-fpm -y
RUN apt install php7.4-{cli,common,curl,zip,mysql,mbstring,json} -y

USER container
ENV  USER container
ENV HOME /home/container

WORKDIR /home/container
COPY ./entrypoint.sh /entrypoint.sh


CMD ["/bin/bash", "/entrypoint.sh"]
