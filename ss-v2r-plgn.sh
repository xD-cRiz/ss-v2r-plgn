#!/bin/bash
# Debian 11
# Build: 2023
#Powered By xD`cRiz
ln -fs /usr/share/zoneinfo/Asia/Manila /etc/localtime

PORT="8888"
PASSWORD="cqkvpn"
METHOD="chacha20-ietf-poly1305"

install_require()
{
  clear
  echo "Updating your system."
  {
    sudo apt update
	apt install wget -y
	apt install nginx -y
  } &>/dev/null
}

install_plugin()
{
  echo "Installing V2ray Plugin."
  {
     #Download V2Ray Plugin to Server
	 wget https://github.com/xD-cRiz/ss-v2r-plgn/blob/main/v2ray-plugin-linux-amd64-v1.3.1.tar.gz
	 tar -xf v2ray-plugin-linux-amd64-v1.3.1.tar.gz
	 cp v2ray-plugin_linux_amd64 /usr/bin/v2ray-plugin
  } &>/dev/null
}
  
install_shadowsocks()
{
  echo "Installing shadowsocks-libev."
  {
	 #Install Shadowsocks on Server
	 wget https://raw.githubusercontent.com/xD-cRiz/ss-v2r-plgn/main/shadowsocks-libev-debian.sh
	 chmod +x shadowsocks-libev-debian.sh
	./shadowsocks-libev-debian.sh
  } &>/dev/null
}


install_config()
{
 clear
  echo "Finalizing config..."
  {
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
  } &>/dev/null
}

install_done()
{
  clear
  echo "Shadowsocks+V2ray Plugin"
  echo "IP : $(curl -s https://api.ipify.org)"
  echo "Port : $PORT"
  echo "Password : $PASSWORD"
  echo "Method : $METHOD"
  echo
  echo
  history -c
  rm /root/.installer
  echo "Server will secure this server and reboot after 20 seconds"
  sleep 20
  /sbin/reboot
}

install_require
install_plugin
install_shadowsocks
install_config
install_done
