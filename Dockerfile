# This is the Dockerfile for jaideraf/idzebra-arm64
# Use --platform=linux/amd64 in the docker build command

ARG UBUNTU_VERSION=20.04

FROM ubuntu:${UBUNTU_VERSION}

# set timezone
ENV TZ=America/Sao_Paulo
RUN set -eux; \
    ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# update packages and install dependencies

# https://serverfault.com/a/797318
ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    autoconf \
    automake \
    bison \
    docbook \
    docbook-xml \
    docbook-xsl \
    gcc \
    inkscape \
    libexpat1-dev \
    libicu-dev \
    libidzebra-2.0-modules \
    libtool \
    libwrap0-dev \
    libxml2 \
    libxslt1-dev \
    make \
    pkg-config \
    tcl \
    xsltproc \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /opt

# build Yaz
ADD https://github.com/indexdata/yaz.git#v5.34.2 yaz/
RUN cd yaz ; \
    ./buildconf.sh; \
    ./configure --with-iconv --with-icu; \
    make; \
    make install

# build Zebra
ADD https://github.com/indexdata/idzebra.git#v2.2.7 idzebra/
RUN cd idzebra ; \
    ./buildconf.sh; \
    ./configure --enable-mod-dom; \
    make; \
    make install

# remove things after compilation
RUN apt purge -y \
    autoconf \
    automake \
    docbook \
    docbook-xml \
    docbook-xsl \
    gcc \
    inkscape \
    libtool \
    libwrap0-dev \
    make \
    pkg-config

CMD ["/bin/sh", "-c", "bash"]