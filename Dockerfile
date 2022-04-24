FROM --platform=$BUILDPLATFORM php:7.2-fpm-alpine

ARG BUILD_DATE
ARG VCS_REF

LABEL org.label-schema.schema-version="1.0" \
      org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.name="barcus/php-fpm-alpine" \
      org.label-schema.description="Docker image for PHP-fpm" \
      org.label-schema.vcs-url="https://github.com/barcus/docker-php-fpm-alpine" \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.version="7.2-fpm-alpine" \
      org.label-schema.image.authors="barcus@tou.nu"

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
