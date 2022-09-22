FROM amazonlinux:2 AS graalvm-java11-aws-lambda-builder
MAINTAINER Muhammad Hamadto <muhamadto@gmail.com>

ENV JAVA_VERSION=11
ENV GRAALVM_VERSION=21.1.0
ENV FILE_NAME=graalvm-ce-java${JAVA_VERSION}-linux-amd64-${GRAALVM_VERSION}.tar.gz
ENV JAVA_HOME=/opt/graalvm-ce-java${JAVA_VERSION}-${GRAALVM_VERSION}

WORKDIR /opt

RUN yum -y update && yum install -y wget tar gzip bzip2-devel ed gcc gcc-c++ gcc-gfortran \
    less libcurl-devel openssl openssl-devel readline-devel xz-devel zlib-devel glibc-static \
    libcxx libcxx-devel llvm-toolset-7 zlib-static
RUN rm -rf /var/cache/yum

RUN wget https://github.com/graalvm/graalvm-ce-builds/releases/download/vm-${GRAALVM_VERSION}/${FILE_NAME}
RUN tar zxvf ${FILE_NAME} && rm -f ${FILE_NAME}
RUN ${JAVA_HOME}/bin/gu install native-image


RUN mkdir ~/.m2

COPY files/settings.xml ~/.m2/settings.xml

WORKDIR /opt/build
