#!/bin/sh

# Mock group and passwd files
echo "${USER_GROUP}:x:$(id -g)" >> "${NSS_WRAPPER_GROUP}";
echo "${USER_NAME}:x:$(id -u):$(id -g):${USER_NAME}:${USER_HOME}:/sbin/nologin" >> "${NSS_WRAPPER_PASSWD}";

exec "$@"
