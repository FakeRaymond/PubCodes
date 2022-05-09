# Scripts for GFW

## Download v2rayN+xray for Windows

### Preparation

``` shell
apt update && apt -y install zip unzip 
```

### Run once

```shell
mkdir -p /root/.script
cd /root/.script
curl -o get_v2rayN_xray.sh -sL https://raw.githubusercontent.com/FakeRaymond/myPubScripts/main/ScriptsForGFW/get_v2rayN_xray.sh
bash get_v2rayN_xray.sh
```

### CRONTAB

``` shell
(crontab -l; echo "*/10 * * * * cd /root/.script && /bin/bash get_v2rayN_xray.sh > /dev/null") | crontab -
```

## Install MTG

``` shell
mkdir -p /root/.script
cd /root/.script
curl -o install_mtg.sh -sL https://raw.githubusercontent.com/FakeRaymond/myPubScripts/main/ScriptsForGFW/install_mtg.sh
```

### for ARM64

``` shell
bash install_mtg.sh arm64
```

### for AMD64

``` shell
bash install_mtg.sh amd64
```
