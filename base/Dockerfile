ARG BUILD_NODE_IMAGE

FROM ${BUILD_NODE_IMAGE}

ENV APP_ROOT="/usr/src/app" \
    HOME="/home/node"

RUN set -ex; \
    # Remove useless accounts
    deluser node --remove-home; \
    # Prepare base folders
    mkdir -p \
        "${APP_ROOT}" \
        "${HOME}"; \
    # Execute node as any user
    chgrp -R 0 \
        "${APP_ROOT}" \
        "${HOME}"; \
    chmod -R g+rwX \
        "${APP_ROOT}" \
        "${HOME}"

USER 1001

WORKDIR "${APP_ROOT}"

STOPSIGNAL SIGTERM

CMD ["node"]
