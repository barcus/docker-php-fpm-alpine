FROM php:fpm-alpine

MAINTAINER Barcus <barcus@tou.nu>

ENV TIMEZONE=Europe/Paris
RUN apk add --no-cache gettext && \
    apk add --no-cache --virtual .build-dependencies gettext-dev && \
    docker-php-ext-install gettext mysqli && \
    apk del .build-dependencies 

COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod u+x /docker-entrypoint.sh

EXPOSE 9000

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["/usr/bin/env", "php-fpm"]
