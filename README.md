# Node

Node docker container image that requires no specific user or root permission to function.

Docker Hub image: [https://hub.docker.com/r/aerzas/node](https://hub.docker.com/r/aerzas/node)

## Docker compose example

```yaml
version: '3.5'
services:
    php:
        image: aerzas/node:19-latest
        command:
            - npm
            - start
        volumes:
            - ./my_app:/usr/src/app
        ports:
            - '8080:8080'
```
