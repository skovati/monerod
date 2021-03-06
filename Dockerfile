FROM ubuntu:20.04 AS build

ENV MONERO_VERSION=0.17.1.9 MONERO_SHA256=0fb6f53b7b9b3b205151c652b6c9ca7e735f80bfe78427d1061f042723ee6381

RUN apt-get update && apt-get install -y curl bzip2

WORKDIR /root

RUN curl https://dlsrc.getmonero.org/cli/monero-linux-x64-v$MONERO_VERSION.tar.bz2 -O &&\
  echo "$MONERO_SHA256  monero-linux-x64-v$MONERO_VERSION.tar.bz2" | sha256sum -c - &&\
  tar -xvf monero-linux-x64-v$MONERO_VERSION.tar.bz2 &&\
  rm monero-linux-x64-v$MONERO_VERSION.tar.bz2 &&\
  cp ./monero-x86_64-linux-gnu-v$MONERO_VERSION/monerod . &&\
  rm -r monero-*
  
FROM ubuntu:20.04

# Create monero user
RUN useradd -ms /bin/bash monero && \
  mkdir -p /monero && \
  chown -R monero:monero /monero
USER monero

COPY --chown=monero:monero --from=build /root/monerod /usr/local/bin/monerod

# Blockchain location
VOLUME /monero

EXPOSE 18080 18081

ENTRYPOINT ["monerod"]
CMD ["--rpc-bind-ip=0.0.0.0", "--data-dir=/monero", "--rpc-ssl=enabled", "--restricted-rpc", "--public-node", "--confirm-external-bind",  "--non-interactive", "--no-zmq", "--log-level=1"]
