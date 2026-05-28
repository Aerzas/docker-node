ARG BUILD_NODE_IMAGE

FROM ${BUILD_NODE_IMAGE}

ENV APP_ROOT="/usr/src/app" \
    HOME="/home/node" \
    NPM_CONFIG_PREFIX="/home/node/.npm"

RUN set -ex; \
    # Remove useless accounts
    deluser node --remove-home; \
    # Prepare base folders
    mkdir -p \
        "${APP_ROOT}" \
        "${HOME}" \
        "${NPM_CONFIG_PREFIX}"; \
    # Execute node as any user
    chgrp -R 0 \
        "${APP_ROOT}" \
        "${HOME}" \
        "${NPM_CONFIG_PREFIX}"; \
    chmod -R g+rwX \
        "${APP_ROOT}" \
        "${HOME}" \
        "${NPM_CONFIG_PREFIX}"

USER 1001

COPY conf/profile.d/*.sh /etc/profile.d/

WORKDIR "${APP_ROOT}"

STOPSIGNAL SIGTERM

CMD ["node"]
