# spring-native-amazonlinux2-base [![Create and publish a Docker image](https://github.com/muhamadto/spring-native-amazonlinux2-base/actions/workflows/docker-image.yml/badge.svg)](https://github.com/muhamadto/spring-native-amazonlinux2-base/actions/workflows/docker-image.yml)
This is a base builder image for building spring-native AWS Lambda function in amazonlinux2 architecture.

Example Usage:
```
FROM ghcr.io/muhamadto/spring-native-amazonlinux2-base-java17:latest AS spring-native-aws-lambda-builder-java17

COPY . /opt/build

RUN ./mvnw -ntp -Pnative package -DskipTests
```
