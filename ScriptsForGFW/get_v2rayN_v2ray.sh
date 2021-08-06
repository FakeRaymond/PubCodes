myfun() {
    myFile=$1

    if [ ! -f "$myFile" ]; then
        touch "$myFile"
    fi

    read line <$myFile

    latest_xray=$(curl -s $2 | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')

    if [ "$line" == "$latest_xray" ]; then
        echo 0
    else
        echo 1
    fi

    echo $latest_xray >$myFile
}

update1=$(myfun latest_xray https://api.github.com/repos/v2fly/v2ray-core/releases/latest)
update2=$(myfun latest_v2rayN https://api.github.com/repos/2dust/v2rayN/releases/latest)

if [ $(($update1 + $update2)) -gt 0 ]; then
    curl -L -s -o v2ray.zip https://github.com/v2fly/v2ray-core/releases/latest/download/v2ray-windows-64.zip
    curl -L -s -o v2rayN.zip https://github.com/2dust/v2rayN/releases/latest/download/v2rayN.zip
    mkdir -p v2rayN
    unzip -n v2rayN.zip
    unzip -n -d v2rayN v2ray.zip
    rm -rf v2rayN/zh-Hans
    rm -f v2rayN.zip
    rm -f v2ray.zip
    zip -q -m -r v2rayN.zip v2rayN
    mv v2rayN.zip /var/www/html
else
    echo No update
fi
