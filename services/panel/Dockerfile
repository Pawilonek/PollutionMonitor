FROM php:7.3-fpm-alpine

WORKDIR /app

RUN echo "## Install build dependencies ##" \
	&& apk add --update --no-cache --virtual .build-deps libxml2-dev

RUN echo "## Installl required extensions ##" \
	&& docker-php-ext-install xml \
	&& docker-php-ext-install ctype \
	&& docker-php-ext-install iconv

RUN echo "## Clenup build ##" \
	&& apk del .build-deps

RUN echo "## Install Composer (package manager) ##" \
	&& php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \ 
	&& php composer-setup.php --install-dir=/bin --filename=composer \
	&& php -r "unlink('composer-setup.php');"

WORKDIR /app/public

ENTRYPOINT ["php", "-S", "0.0.0.0:80"]
