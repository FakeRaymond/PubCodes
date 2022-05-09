#!/bin/bash
apt-get update && apt-get -y full-upgrade && apt-get -y autoremove && apt-get -y clean && apt-get -y autoclean
