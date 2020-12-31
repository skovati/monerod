# monerod

Runs the monero daemon in an ubuntu based docker image. Find it on Docker Hub [here](https://hub.docker.com/r/skovati/monerod)

![Docker Cloud Build Status](https://img.shields.io/docker/cloud/build/skovati/monerod?style=for-the-badge)

## Usage
```bash
docker run \
  --restart=unless-stopped \
  -v /path/blockchain/will/be/stored:/monero \
  -p 18080:18080 \
  -p 18081:18081 \
  --name=monerod \
  -td skovati/monerod
```

