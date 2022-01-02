# USAGE
``` shell
apt update && apt -qq install zip unzip 
```
```shell
mkdir -p /root/.script
cd /root/.script
wget https://raw.githubusercontent.com/FakeRaymond/myPubScripts/main/ScriptsForGFW/get_v2rayN_xray.sh
bash get_v2rayN_xray.sh
```
# USE CRONTAB
``` shell
(crontab -l; echo "*/10 * * * * cd /root/.script && /bin/bash get_v2rayN_xray.sh > /dev/null") | crontab -
```
