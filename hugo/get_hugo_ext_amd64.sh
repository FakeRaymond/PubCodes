#!/bin/bash

newtag=$(curl -s https://api.github.com/repos/gohugoio/hugo/releases/latest | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')
pkg="hugo_extended_"${newtag:1}"_Linux-64bit.tar.gz"
curl -LOs "https://github.com/gohugoio/hugo/releases/download/"$newtag"/"$pkg
tar -xzvf $pkg
mv hugo /usr/local/bin
rm $pkg LICENSE README.md
