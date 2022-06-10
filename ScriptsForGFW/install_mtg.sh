#!/bin/bash
set -x

new_release_tag=$(curl -sL https://api.github.com/repos/9seconds/mtg/releases/latest | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')
new_release="mtg-"${new_release_tag:1}"-linux-"$1".tar.gz"

curl -sL -O "https://github.com/9seconds/mtg/releases/download/"$new_release_tag"/"$new_release
tar -xzvf $new_release
mv ./mtg*/mtg /usr/local/bin
rm -rf mtg-*

rm /etc/mtg.toml
curl -o /etc/mtg.toml -sL https://raw.githubusercontent.com/FakeRaymond/myPubScripts/main/ScriptsForGFW/mtg.toml

cat <<EOF >/etc/systemd/system/mtg.service
[Unit]
Description=MTG Proxy
After=network.target

[Service]
ExecStart=/usr/local/bin/mtg run /etc/mtg.toml
Restart=always

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload
systemctl start mtg
systemctl enable mtg

mtg access /etc/mtg.toml
