FROM ubuntu:rolling

ENV PATH=/opt/z-way-server:$PATH
ENV ZWAY_VERSION=3.2.3

RUN chmod 1777 /tmp

RUN apt-get update -y \
  && DEBIAN_FRONTEND=noninteractive TZ=Etc/UTC apt-get install -y \
        curl \
        libarchive13 \
        libxml2 \
        sharutils \
        tzdata \
        gawk \
        libc-ares2 \
        libavahi-compat-libdnssd-dev \
        libwebsockets16 \
        libmosquitto1 \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
  && ln -s /usr/lib/x86_64-linux-gnu/libwebsockets.so.16 /usr/lib/x86_64-linux-gnu/libwebsockets.so.15

RUN curl -SLO https://storage.z-wave.me/z-way-server/z-way-${ZWAY_VERSION}_amd64.deb \
 && dpkg -i z-way-${ZWAY_VERSION}_amd64.deb \
 && rm z-way-${ZWAY_VERSION}_amd64.deb

EXPOSE 8083

WORKDIR /opt/z-way-server

ENTRYPOINT ["z-way-server", "-L", "/dev/stdout", "-l", "1"]