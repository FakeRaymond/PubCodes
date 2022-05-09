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
    curl -o xray.zip -sL https://github.com/XTLS/Xray-core/releases/latest/download/Xray-windows-64.zip
    curl -o v2rayN.zip -sL https://github.com/2dust/v2rayN/releases/latest/download/v2rayN.zip
    mkdir -p v2rayN
    unzip -n v2rayN.zip
    unzip -n -d v2rayN xray.zip
    rm -rf v2rayN/zh-Hans
    rm -f v2rayN.zip
    rm -f xray.zip
    zip -q -m -r v2rayN.zip v2rayN
    mv v2rayN.zip /var/www/html
else
    echo "No update"
fi
