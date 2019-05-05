#!/bin/sh
set -e

if [ "${DOMAIN}" == "**None**" ]; then
    echo "Please set DOMAIN"
    exit 1
fi

if [ ! -f "${BUILD_DIR}/bin/ngrokd" ]; then
    echo "ngrokd is not build,will be build it now..."
    /bin/sh /build.sh
fi


${BUILD_DIR}/bin/ngrokd -tlsKey=${CERT_DIR}/${SERVER_KEY} -tlsCrt=${CERT_DIR}/${SERVER_CRT} -domain="${DOMAIN}" -httpAddr=${HTTP_ADDR} -httpsAddr=${HTTPS_ADDR} -tunnelAddr=${TUNNEL_ADDR}
