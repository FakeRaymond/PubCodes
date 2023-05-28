#!/bin/bash

check() {
    target=$1
    url=$2

    if [ ! -f "$target" ]; then
        touch "$target"
        tag_name_pre=""
    else
        read tag_name_pre <$target
    fi

    tag_name_latest=$(curl -sL $url | grep -oP '"tag_name": ".*?"' | awk -F '"' '{print $4}')

    echo "$tag_name_latest" >$target

    if [ "$tag_name_pre" == "$tag_name_latest" ]; then
        # No update
        echo 0
    else
        # Need update
        echo 1
    fi

}

update1=$(check latest_xray https://api.github.com/repos/XTLS/Xray-core/releases/latest)
update2=$(check latest_v2rayN https://api.github.com/repos/2dust/v2rayN/releases/latest)

if [[ $update1 == 1 || $update2 == 1 ]]; then
    curl -o xray-core.zip -sL https://github.com/XTLS/Xray-core/releases/latest/download/Xray-windows-64.zip
    curl -o v2rayN.zip -sL https://github.com/2dust/v2rayN/releases/latest/download/v2rayN.zip
    unzip -n v2rayN.zip
    unzip -n -d xray-core xray-core.zip
    mv xray-core/xray.exe v2rayN/bin/Xray
    mv xray-core/wxray.exe v2rayN/bin/Xray
    curl -o v2rayN/bin/geoip.dat -sL https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geoip.dat
    curl -o v2rayN/bin/geosite.dat -sL https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geosite.dat
    zip -q -m -r v2rayN-core.zip v2rayN
    rm -rf xray-core.zip v2rayN.zip xray-core
    mv v2rayN-core.zip /var/www/html/v2rayN.zip
else
    echo "No update"
fi
