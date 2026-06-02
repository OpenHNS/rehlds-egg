FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive \
    TZ=UTC
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

RUN dpkg --add-architecture i386 && apt-get update && \
    apt-get install -y --no-install-recommends \
      ca-certificates curl jq unzip tini tzdata gdb \
      libc6:i386 libstdc++6:i386 zlib1g:i386 libgcc-s1:i386 libcurl4:i386 \
      libncurses6:i386 libtinfo6:i386 lib32z1 && \
    rm -rf /var/lib/apt/lists/*

RUN useradd -m -d /home/container -s /bin/bash container && \
    mkdir -p /home/container && \
    chown -R container:container /home/container

USER container
WORKDIR /home/container

COPY --chown=container:container entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/usr/bin/tini", "--"]
CMD ["/bin/bash", "/entrypoint.sh"]
