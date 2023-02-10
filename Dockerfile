# This is the Dockerfile for jaideraf/idzebra-arm64

FROM --platform=linux/arm64 ubuntu:jammy

# set timezone
ENV DEBIAN_FRONTEND noninteractive
ENV TZ=America/Sao_Paulo
RUN set -eux; \
    ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# update packages and install dependencies
RUN apt-get update && apt-get install -y \
    autoconf \
    automake \
    bison \
    docbook \
    docbook-xml \
    docbook-xsl \
    gcc \
    git \
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
RUN git clone https://github.com/indexdata/yaz.git; \
    cd yaz && git checkout v5.34.0; \
    ./buildconf.sh; \
    ./configure --with-iconv --with-icu; \
    make; \
    make install

# build Zebra
RUN git clone https://github.com/indexdata/idzebra.git; \
    cd idzebra && git checkout v2.2.7; \
    ./buildconf.sh; \
    ./configure --enable-mod-dom; \
    make; \
    make install

# remove things after compilation
RUN apt purge -y \
    docbook \
    docbook-xml \
    docbook-xsl \
    inkscape
