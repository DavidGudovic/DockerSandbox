#################################### PHP base image build stage ####################################

FROM php:8.2-fpm-alpine AS app

COPY --from=mlocati/php-extension-installer /usr/bin/install-php-extensions /usr/local/bin/

RUN apk add --no-cache \
    bash \
    acl \
    fcgi \
    file \
    gettext \
    git \
    ;

RUN set -eux; \
    install-php-extensions \
     pdo \
     pdo_mysql \
     intl \
     zip \
     apcu \
     opcache \
    ;

ENV COMPOSER_ALLOW_SUPERUSER=1

COPY --from=composer:2.4 /usr/bin/composer /usr/bin/composer

COPY ./app/composer.* ./

RUN composer install --prefer-dist --no-dev --no-scripts --no-progress --no-interaction

COPY ./app .

RUN composer dump-autoload --optimize

############################## X-Debug installation build stage ##################################

FROM app AS app_dev

ENV XDEBUG_MODE=off

COPY ./php/conf.d/xdebug.ini $PHP_INI_DIR/conf.d/xdebug.ini

RUN set -eux; \
    install-php-extensions xdebug;

RUN curl -sS https://get.symfony.com/cli/installer | bash
RUN mv /root/.symfony*/bin/symfony /usr/local/bin/symfony