ARG BUILD_NODE_IMAGE

FROM ${BUILD_NODE_IMAGE}

USER root

ENV NSS_WRAPPER_GROUP=/tmp/group \
    NSS_WRAPPER_PASSWD=/tmp/passwd

RUN set -ex; \
    # Install build packages
    apk add --no-cache autoconf automake g++ libc6-compat libjpeg-turbo-dev libpng-dev libtool make nasm rsync; \
    # Install Git and SSH client
    apk add --no-cache git openssh-client; \
    echo -e "Host *\n  StrictHostKeyChecking accept-new" > /etc/ssh/ssh_config; \
    # Install corepack
    npm install --no-update-notifier --prefix /usr/local/ --global corepack; \
    # NSS wrapper
    apk add --no-cache nss_wrapper; \
    touch \
      "${NSS_WRAPPER_GROUP}" \
      "${NSS_WRAPPER_PASSWD}"; \
    chmod u+rw,g+rw,o+rw \
      "${NSS_WRAPPER_GROUP}" \
      "${NSS_WRAPPER_PASSWD}"

ENV USER_HOME=/tmp \
    USER_GROUP=docker \
    USER_NAME=docker

USER 1001

COPY scripts/docker-entrypoint.sh /scripts/docker-entrypoint.sh

ENTRYPOINT ["/scripts/docker-entrypoint.sh"]
