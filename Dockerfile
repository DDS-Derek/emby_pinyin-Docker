FROM alpine:3.19

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

ENV LANG=C.UTF-8 \
    PS1="\[\e[32m\][\[\e[m\]\[\e[36m\]\u \[\e[m\]\[\e[37m\]@ \[\e[m\]\[\e[34m\]\h\[\e[m\]\[\e[32m\]]\[\e[m\] \[\e[37;35m\]in\[\e[m\] \[\e[33m\]\w\[\e[m\] \[\e[32m\][\[\e[m\]\[\e[37m\]\d\[\e[m\] \[\e[m\]\[\e[37m\]\t\[\e[m\]\[\e[32m\]]\[\e[m\] \n\[\e[1;31m\]$ \[\e[0m\]" \
    S6_SERVICES_GRACETIME=30000 \
    S6_KILL_GRACETIME=60000 \
    S6_CMD_WAIT_FOR_SERVICES_MAXTIME=0 \
    S6_SYNC_DISKS=1 \
    TZ=Asia/Shanghai \
    CRON_ENABLED=true \
    CRON_SCHEDULE="0 * * * *" \
    HOST= \
    API_KEY= \
    SORT_TYPE=1