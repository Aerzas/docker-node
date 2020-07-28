#!/bin/sh
if ! id -u "$(id -u)" > /dev/null 2>&1; then
  echo "${USER_NAME}:x:$(id -u):$(id -g):${USER_NAME}:${USER_HOME}:/sbin/nologin" >> /etc/passwd;
fi

exec "$@"
