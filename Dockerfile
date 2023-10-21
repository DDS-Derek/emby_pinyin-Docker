FROM alpine:3.18

RUN set -ex && \
    apk add --no-cache \
        bash \
        netcat-openbsd \
        curl \
        tzdata \
        s6-overlay \
        php81 \
        php81-curl \
        php81-dev \
        php81-iconv \
        php81-json \
        php81-mbstring \
        php81-openssl \
        php81-phar \
        php81-zip \
        composer && \
    apk add --no-cache --virtual=build-dependencies git && \
    sed -i "s#;phar.readonly = On#phar.readonly = Off#g" /etc/php81/php.ini && \
    git clone -b master https://github.com/hisune/emby_pinyin.git /app && \
    cd /app && \
    composer pre-install && \
    apk del --purge build-dependencies && \
    rm -rf \
        /app/.git \
        /var/cache/apk/* \
        /usr/share/man \
        /tmp/*

COPY --chmod=755 ./rootfs /

ENTRYPOINT [ "/init" ]

EXPOSE 6786

ENV TZ=Asia/Shanghai \
    CRON_ENABLED=true \
    CRON_SCHEDULE="0 * * * *" \
    HOST= \
    API_KEY= \
    SORT_TYPE=1