ARG BUILD_NODE_IMAGE

FROM ${BUILD_NODE_IMAGE}

USER root

RUN set -ex; \
    # Install build packages
    apk add --no-cache autoconf automake g++ libc6-compat libjpeg-turbo-dev libpng-dev libtool make nasm rsync; \
    # Install Git and SSH client
    apk add --no-cache git openssh-client; \
    echo -e "Host *\n  StrictHostKeyChecking accept-new" > /etc/ssh/ssh_config; \
    # Replace this hack whith NSS wrapper once accepted
    # see https://bugs.alpinelinux.org/issues/6710
    chgrp 0 /etc/passwd; \
    chmod g+rwX /etc/passwd

ENV USER_HOME=/tmp \
    USER_NAME=docker

USER 1001

COPY scripts/docker-entrypoint.sh /scripts/docker-entrypoint.sh

ENTRYPOINT ["/scripts/docker-entrypoint.sh"]
