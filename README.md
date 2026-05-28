# Node

Node docker container image that requires no specific user or root permission to function.

Docker Hub image: [https://hub.docker.com/r/aerzas/node](https://hub.docker.com/r/aerzas/node)

## Docker compose example

```yaml
services:
    php:
        image: aerzas/node:26-latest
        command:
            - npm
            - start
        volumes:
            - ./my_app:/usr/src/app
        ports:
            - '8080:8080'
```

## Environment Variables

| Variable                   | Default value (base) | Default value (dev) |
|----------------------------|----------------------|---------------------|
| **Node**                   |                      |                     |
| `APP_ROOT`                 | `/usr/src/app`       | `/usr/src/app`      |
| `HOME`                     | `/home/node`         | `/home/node`        |
| `NPM_CONFIG_PREFIX`        | `/home/node/.npm`    | `/home/node/.npm`   |
| **NSS wrapper (dev only)** |                      |                     |
| `NSS_WRAPPER_GROUP`        |                      | `/tmp/group`        |
| `NSS_WRAPPER_PASSWD`       |                      | `/tmp/passwd`       |
| **User (dev only)**        |                      |                     |
| `USER_HOME`                |                      | `/tmp`              |
| `USER_GROUP`               |                      | `docker`            |
| `USER_NAME`                |                      | `docker`            |
