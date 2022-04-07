#!/bin/bash -e
bakdns() {
	if [ "$1" == "0" ]; then
		echo "119.29.29.29"
	elif [ "$1" == "1" ]; then
		echo "101.226.4.6"
	fi
}

exist() {
  command -v "$1" >/dev/null 2>&1
}

getdat() {
  if exist curl; then
    curl -fSLo "$TMPDIR/$1" "https://ghproxy.com/https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/$1"
  else
    wget "https://ghproxy.com/https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/$1" -nv -O "$TMPDIR/$1"
  fi
}

get_ADlist() {
  if exist curl; then
    curl -fSLo "$TMPDIR/$1" "https://raw.cooluc.com/QiuSimons/openwrt-mos/master/dat/$1"
  else
    wget "https://raw.cooluc.com/QiuSimons/openwrt-mos/master/dat/$1" -nv -O "$TMPDIR/$1"
  fi
}

get_config() {
  if exist curl; then
    curl -fSLo "$TMPDIR/$1" "https://raw.cooluc.com/sbwml/luci-app-mosdns/master/root/etc/mosdns/$1"
  else
    wget "https://raw.cooluc.com/sbwml/luci-app-mosdns/master/root/etc/mosdns/$1" -nv -O "$TMPDIR/$1"
  fi
}

getdns() {
  if [ "$2" == "inactive" ]; then
    ubus call network.interface.wan status | jsonfilter -e "@['inactive']['dns-server'][$1]"
  else
    ubus call network.interface.wan status | jsonfilter -e "@['dns-server'][$1]"
  fi
}

pid() {
	pgrep -f "$1"
}


L_exist() {
	if [ "$1" == "ssrp" ]; then
		uci get shadowsocksr.@global[0].global_server &>/dev/null
	elif [ "$1" == "pw" ]; then
		uci get passwall.@global[0].enabled &>/dev/null
	elif [ "$1" == "vssr" ]; then
		uci get vssr.@global[0].global_server &>/dev/null
	fi
}
