#!/bin/bash
#=================================================
#   Description: DIY script
#   Lisence: MIT
#   Author: P3TERX
#   Blog: https://p3terx.com
#=================================================
#克隆源码
git clone -b openwrt-18.06 --single-branch https://github.com/immortalwrt/immortalwrt openwrt
cd openwrt
./scripts/feeds update -a
./scripts/feeds install -a

mv ../config/immortalwrt_mt7621_hiwifi_hc5962.dts target/linux/ramips/dts/mt7621_hiwifi_hc5962.dts
mv ../config/immortalwrt_02_network target/linux/ramips/mt7621/base-files/etc/board.d/02_network
sed -i "s/hiwifi_hc5962/cmcc_an1201l/g" `grep hiwifi_hc5962 -rl target`
sed -i "s/HC5962/AN1201L/g" `grep HC5962 -rl target`
sed -i "s/hc5962/an1201l/g" `grep hc5962 -rl target`
sed -i "s/HiWiFi/CMCC/g" `grep HiWiFi -rl target`
sed -i "s/hiwifi/cmcc/g" `grep hiwifi -rl target`
cp target/linux/ramips/dts/mt7621_hiwifi_hc5962.dts target/linux/ramips/dts/mt7621_cmcc_an1201l.dts
touch target/linux/*/Makefile

#添加自定义插件
git clone https://github.com/small-5/luci-app-adblock-plus.git package/luci-app-adblock-plus
git clone https://github.com/ntlf9t/luci-app-easymesh package/luci-app-easymesh
#添加主题
git clone https://github.com/jerrykuku/luci-theme-argon.git package/luci-theme-argon-2.2.9
svn co https://github.com/kenzok8/openwrt-packages/trunk/luci-theme-edge package/luci-theme-edge
git clone https://github.com/jerrykuku/luci-theme-argon.git package/luci-theme-argon-1.7.2

#修改lan口地址
sed -i 's/192.168.1.1/192.168.10.1/g' package/base-files/files/bin/config_generate                                  
#修改机器名称
sed -i 's/OpenWrt/AN1201L/g' package/base-files/files/bin/config_generate
#修改wifi名称
sed -i 's/OpenWrt/AN1201L/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh
#默认打开WiFi
sed -i 's/disabled=1/disabled=0/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh
#修改时区
#sed -i "s/'UTC'/'CST-8'\n        set system.@system[-1].zonename='Asia\/Shanghai'/g" package/base-files/files/bin/config_generate

#sed -i '/exit 0/i\uci set network.wan.macaddr=F0:68:65:0C:51:98' package/emortal/default-settings/files/99-default-settings
#sed -i '/exit 0/i\uci set network.lan.macaddr=F0:68:65:0C:51:97' package/emortal/default-settings/files/99-default-settings
#sed -i '/exit 0/i\uci commit network' package/emortal/default-settings/files/99-default-settings
#sed -i '/exit 0/i\ifdown wan && ifup wan' package/emortal/default-settings/files/99-default-settings
#sed -i '/exit 0/i\ifdown lan && ifup lan' package/emortal/default-settings/files/99-default-settings

#加载config
[ -e ../config/4.14_immortalwrt_an1201l.config ] && mv -f ../config/4.14_immortalwrt_an1201l.config .config
