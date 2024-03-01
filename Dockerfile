FROM eclipse-mosquitto:2

ARG UID
ARG GID
ARG USER

RUN set -eux; \
    if [ "${USER}" != "root" ]; then \
        apk add --no-cache shadow; \
        groupadd -f -g ${GID} ${USER} || true; \
        useradd -m -g ${USER} -u ${UID} ${USER} || true; \
    fi

RUN if [ "${USER}" != "root" ]; then \
        chown -R ${USER}:${USER} /mosquitto; \
    fi

USER ${USER}
