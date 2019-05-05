#!/bin/sh
set -e

if [ "${DOMAIN}" == "**None**" ]; then
    echo "Please set DOMAIN"
    exit 1
fi

if [ ! -d ${CERT_DIR}  ];then
  mkdir ${CERT_DIR}
fi

cd ${CERT_DIR}
if [ ! -f "${CERT_DIR}/${CLIENT_CRT}" ]; then
    echo "generator client and server cert file"
    openssl genrsa -out client.key 2048
    openssl req -new -x509 -nodes -key client.key -days 10000 -subj "/CN=${DOMAIN}" -out ${CLIENT_CRT}
    openssl genrsa -out ${SERVER_KEY} 2048
    openssl req -new -key ${SERVER_KEY} -subj "/CN=${DOMAIN}" -out server.csr
    openssl x509 -req -in server.csr -CA ${CLIENT_CRT} -CAkey client.key -CAcreateserial -days 10000 -out ${SERVER_CRT}
fi
cp -r ${CLIENT_CRT} /ngrok/assets/client/tls/ngrokroot.crt

cd /ngrok
make release-server
GOOS=linux GOARCH=386 make release-client
GOOS=linux GOARCH=amd64 make release-client
GOOS=windows GOARCH=386 make release-client
GOOS=windows GOARCH=amd64 make release-client
GOOS=darwin GOARCH=386 make release-client
GOOS=darwin GOARCH=amd64 make release-client
GOOS=linux GOARCH=arm make release-client

cp -r /ngrok/bin ${BUILD_DIR}/bin

echo "build ok !"