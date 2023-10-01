FROM ubuntu:focal

ENV PATH=/opt/z-way-server:$PATH
ENV ZWAY_VERSION=4.1.1

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
	  libwebsockets15 \
	  libmosquitto1 \
	  libcurl3-gnutls \
	  logrotate \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN curl -SLO https://storage.z-wave.me/z-way-server/z-way-${ZWAY_VERSION}_amd64.deb \
 && dpkg -i z-way-${ZWAY_VERSION}_amd64.deb \
 && rm z-way-${ZWAY_VERSION}_amd64.deb

EXPOSE 8083

WORKDIR /opt/z-way-server

ENTRYPOINT ["z-way-server", "-L", "/dev/stdout", "-l", "1"]
