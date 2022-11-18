# spring-native-amazonlinux2-base [![Publish Docker Image](https://github.com/muhamadto/spring-native-amazonlinux2-base/actions/workflows/docker-image.yml/badge.svg)](https://github.com/muhamadto/spring-native-amazonlinux2-base/actions/workflows/docker-image.yml)

> :warning: This branch is not supported anymore.

This is a base builder image for building spring-native AWS Lambda function in amazonlinux2 architecture.

Example Usage:

```
FROM ghcr.io/muhamadto/spring-native-amazonlinux2-base-java11:latest AS spring-native-aws-lambda-builder-java11

COPY . /opt/build

RUN ./mvnw -ntp -Pnative package -DskipTests
```
