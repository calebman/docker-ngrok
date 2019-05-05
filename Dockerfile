FROM golang:1.11.9-alpine3.9

RUN apk add --no-cache git make openssl
RUN git clone https://github.com/inconshreveable/ngrok.git /ngrok

ADD *.sh /

ENV DOMAIN **None**
ENV BUILD_DIR /home/ngrok
ENV TUNNEL_ADDR :443
ENV HTTP_ADDR :80
ENV HTTPS_ADDR :6443
ENV CERT_DIR /cert
ENV CLIENT_CRT client.crt
ENV SERVER_CRT server.crt
ENV SERVER_KEY server.key

EXPOSE 443
EXPOSE 80
EXPOSE 6443

CMD /bin/sh
