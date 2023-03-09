#!/bin/bash
# Debian 11
# Build: 2023
#Powered By xD`cRiz
ln -fs /usr/share/zoneinfo/Asia/Manila /etc/localtime

PORT="8888"
PASSWORD="criz.romero"
METHOD="chacha20-ietf-poly1305"

    sudo apt update
	apt install wget -y
	apt install nginx -y

     #Download V2Ray Plugin to Server
	 wget https://github.com/shadowsocks/v2ray-plugin/releases/download/v1.3.1/v2ray-plugin-linux-amd64-v1.3.1.tar.gz
	 tar -xf v2ray-plugin-linux-amd64-v1.3.1.tar.gz
	 cp v2ray-plugin_linux_amd64 /usr/bin/v2ray-plugin

	 #Install Shadowsocks on Server
	 wget https://raw.githubusercontent.com/teddysun/shadowsocks_install/master/shadowsocks-libev-debian.sh
	 chmod +x shadowsocks-libev-debian.sh
	./shadowsocks-libev-debian.sh


cat <<EOF >/etc/shadowsocks-libev/config.json
{
    "server":"0.0.0.0",
    "server_port":$PORT,
    "password":"$PASSWORD",
    "timeout":300,
    "user":"nobody",
    "method":"chacha20-ietf-poly1305",
    "fast_open":false,
    "nameserver":"1.0.0.1",
    "mode":"tcp_and_udp",
    "plugin":"/usr/bin/v2ray-plugin",
    "plugin_opts":"server;path=/"
}
EOF
