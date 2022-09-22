# Licensed to Muhammad Hamadto

#   Licensed under the Apache License, Version 2.0 (the "License");
#   you may not use this file except in compliance with the License.
#   You may obtain a copy of the License at
#     http://www.apache.org/licenses/LICENSE-2.0

#   See the NOTICE file distributed with this work for additional information regarding copyright ownership.

#   Unless required by applicable law or agreed to in writing, software
#   distributed under the License is distributed on an "AS IS" BASIS,
#   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#   See the License for the specific language governing permissions and
#   limitations under the License.

FROM amazonlinux:2 AS spring-native-aws-lambda-builder-java17-base

LABEL Description="This is a base builder image for building spring-native AWS Lambda function in amazonlinux2 architecture"

ENV JAVA_VERSION=17
ENV GRAALVM_VERSION=22.2.0
ENV FILE_NAME=graalvm-ce-java${JAVA_VERSION}-linux-amd64-${GRAALVM_VERSION}.tar.gz
ENV JAVA_HOME=/opt/graalvm-ce-java${JAVA_VERSION}-${GRAALVM_VERSION}

ENV GROUP_NAME=builders
ENV GROUP_ID=1000

ENV USER_NAME=githubactions
ENV USER_ID=1000

WORKDIR /opt

USER root
RUN mkdir -p /opt/build
RUN yum -y update
RUN yum install -y wget tar gzip bzip2-devel ed gcc gcc-c++ gcc-gfortran \
    less libcurl-devel openssl openssl-devel readline-devel xz-devel \
    zlib-devel glibc-static libcxx libcxx-devel llvm-toolset-7 zlib-static shadow-utils
RUN rm -rf /var/cache/yum

RUN wget https://github.com/graalvm/graalvm-ce-builds/releases/download/vm-${GRAALVM_VERSION}/${FILE_NAME}
RUN tar zxvf ${FILE_NAME} && rm -f ${FILE_NAME}
RUN ${JAVA_HOME}/bin/gu install native-image

RUN groupadd -g ${GROUP_ID} ${GROUP_NAME}
RUN useradd -c "Builders user" -d /home/${USER_NAME} -u ${USER_ID} -g ${GROUP_ID} -m ${USER_NAME}

RUN chown -R ${USER_NAME}:${GROUP_NAME} /opt/build

USER ${USER_NAME}
RUN mkdir /home/${USER_NAME}/.m2
RUN chown -R ${USER_NAME}:${GROUP_NAME} /home/${USER_NAME}/.m2
COPY files/settings.xml /home/${USER_NAME}/.m2/settings.xml

WORKDIR /opt/build
