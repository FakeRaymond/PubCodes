#!/bin/bash

new_release_tag=$(curl -s https://api.github.com/repos/9seconds/mtg/releases/latest | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')
new_release="mtg-"${new_release_tag:1}"-linux-"$0".tar.gz"
curl -LOs "https://github.com/9seconds/mtg/releases/download/"$new_release_tag"/"$new_release
tar -xzvf $new_release
mv ./mtg*/mtg /usr/local/bin
rm -rf mtg-*

rm /etc/mtg.toml
curl -o /etc/mtg.toml https://raw.githubusercontent.com/FakeRaymond/myPubScripts/main/ScriptsForGFW/mtg.toml

cat >/etc/systemd/system/mtg.service <<EOF
[Unit]
Description=mtg

[Service]
ExecStart=/usr/local/bin/mtg run /etc/mtg.toml
Restart=always
RestartSec=3

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload
systemctl enable mtg
systemctl start mtg

mtg access /etc/mtg.toml
