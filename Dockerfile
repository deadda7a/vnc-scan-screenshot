FROM debian:stretch-slim

ADD . /app
WORKDIR /app

RUN apt-get update; \
  apt-get upgrade -y; \
  rm -rf /var/lib/apt/lists/*; \
	apt-get clean

RUN apt-get -y install \
  build-essential \
  cmake \
  libgmp3-dev \
  gengetopt \
  libpcap-dev \
  flex \
  byacc \
  libjson-c-dev \
  pkg-config \
  libunistring-dev \
  git \
  vncsnapshot

# Clone, compile and install zmap
RUN git clone https://github.com/zmap/zmap.git /tmp/zmap; \
  cd /tmp/zmap; \
  cmake .; \
  make -j4; \
  make install; \
  rm -rf /tmp/zmap

# make sha512 tool
RUN gcc -o /usr/local/bin/passwd-sha512 ./passwd-sha512.c -lcrypt; \
  chmod +x /usr/local/bin/passwd-sha512

VOLUME ["/data"]
ENTRYPOINT ["/bin/bash", "scan.sh"]
