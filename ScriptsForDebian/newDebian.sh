#!/bin/bash

echo "Input new password:"
read password
echo root:$password|chpasswd

cat <<EOF > /etc/apt/sources.list
deb http://deb.debian.org/debian/ stable main contrib non-free
deb-src http://deb.debian.org/debian/ stable main contrib non-free
deb http://deb.debian.org/debian/ stable-updates main contrib non-free
deb-src http://deb.debian.org/debian/ stable-updates main contrib non-free
deb http://deb.debian.org/debian-security stable/updates main
deb-src http://deb.debian.org/debian-security stable/updates main
EOF

apt-get update -y && apt-get full-upgrade -y && apt-get autoremove -y && apt-get clean -y && apt-get autoclean -y

wget --no-check-certificate -O /opt/bbr.sh https://github.com/teddysun/across/raw/master/bbr.sh
chmod 755 /opt/bbr.sh
/opt/bbr.sh

# menu
menu(){
echo 
}

# add user
add_user(){
    apt-get update && apt-get  -y install sudo
    adduser ray
    usermod -aG sudo ray
}

# config timezone
config_timezone(){
    dpkg-reconfigure tzdata
}

# tweak network interface
config_newwork_interface(){
    cat <<EOF > /etc/network/interfaces
    source /etc/network/interfaces.d/*
    # The loopback network interface
    auto lo
    iface lo inet loopback
    # The primary network interface
    allow-hotplug ens3
    iface ens3 inet dhcp
EOF
    chattr +i /etc/network/interfaces
}

# tweak resolv
config_resolv(){
    cat <<EOF > /etc/resolv.conf
    nameserver 8.8.4.4
    nameserver 1.0.0.1
EOF
    chattr +i /etc/resolv.conf
}

# tweak hostname
config_hostname(){
    cat <<EOF > /etc/hostname
    debian
EOF
}


