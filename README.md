# DOCKER NGROK IMAGE

## How to build

```bash
git clone https://github.com/calebman/docker-ngrok.git
cd docker-ngrok
docker built -t ngrok .
```

## How to use

```bash
docker run --name ngrok-server \
    --restart always \
    -d \
    -v /data/ngrok-data:/home/ngrok --privileged=true \
    -p 4443:4443 \
    -p 680:80 \
    -p 6443:443 \
    -e TUNNEL_ADDR=":4443" \
    -e HTTP_ADDR=":80" \
    -e HTTPS_ADDR=":443" \
    -e DOMAIN="ngrok.chenjianhui.site" chenjianhui0428/ngrok /bin/sh /server.sh
```