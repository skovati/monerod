# monerod
runs the monero daemon in an ubuntu based docker image

## Usage
```
docker run \
  --restart=unless-stopped \
  -v /path/blockchain/will/be/stored:/monero \
  -p 18080:18080 \
  -p 18081:18081 \
  --name=monerod \
  -td skovati/monerod
```

