# emby_pinyin Docker

https://github.com/hisune/emby_pinyin

```shell
docker run -itd \
  --name emby_pinyin \
  -p 6786:6786 \
  -e TZ=Asia/Shanghai \
  -e CRON_ENABLED=true \
  -e CRON_SCHEDULE="0 * * * *" \
  -e HOST= \
  -e API_KEY= \
  -e SORT_TYPE=1 \
  --log-opt max-size=5m \
  ddsderek/emby_pinyin:latest
```

```yaml
version: '3.3'
services:
    emby_pinyin:
        container_name: emby_pinyin
        ports:
            - '6786:6786'
        environment:
            - TZ=Asia/Shanghai
            - CRON_ENABLED=true
            - 'CRON_SCHEDULE=0 * * * *'
            - HOST=
            - API_KEY=
            - SORT_TYPE=1
        logging:
            options:
                max-size: 5m
        image: 'ddsderek/emby_pinyin:latest'
```
