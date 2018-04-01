FROM php:7.2-apache

RUN docker-php-ext-install \
    pdo \
    pdo_mysql

RUN apt-get update && apt-get install -y \
    wget \
    unzip \
    curl \
    git \
    mysql-client

COPY ./www .

RUN a2enmod -q rewrite dir expires headers

CMD ["apache2-foreground"]

