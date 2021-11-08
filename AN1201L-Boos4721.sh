#!/bin/bash
#=================================================
#   Description: DIY script
#   Lisence: MIT
#   Author: P3TERX
#   Blog: https://p3terx.com
#=================================================
#克隆源码
git clone https://github.com/Boos4721/openwrt
cd openwrt
./scripts/feeds update -a
./scripts/feeds install -a -f

mv ../config/Boos4721_mt7621_hiwifi_hc5962.dts target/linux/ramips/dts/mt7621_hiwifi_hc5962.dts
mv ../config/Boos4721_02_network target/linux/ramips/mt7621/base-files/etc/board.d/02_network
sed -i "s/hiwifi_hc5962/cmcc_an1201l/g" `grep hiwifi_hc5962 -rl target`
sed -i "s/HC5962/AN1201L/g" `grep HC5962 -rl target`
sed -i "s/hc5962/an1201l/g" `grep hc5962 -rl target`
sed -i "s/HiWiFi/CMCC/g" `grep HiWiFi -rl target`
sed -i "s/hiwifi/cmcc/g" `grep hiwifi -rl target`
cp target/linux/ramips/dts/mt7621_hiwifi_hc5962.dts target/linux/ramips/dts/mt7621_cmcc_an1201l.dts
touch target/linux/*/Makefile
rm -rf package/kernel/mt76
svn co https://github.com/coolsnowwolf/lede/trunk/package/kernel/mt76 package/kernel/mt76
#添加主题
svn co https://github.com/kenzok8/openwrt-packages/trunk/luci-theme-edge package/luci-theme-edge
git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon.git package/luci-theme-argon-1.7.2

#修改lan口地址
sed -i 's/10.10.10.1/192.168.10.1/g' package/base-files/files/bin/config_generate
#修改机器名称
sed -i 's/OpenWrt/AN1201L/g' package/base-files/files/bin/config_generate
#修改wifi名称
sed -i 's/OpenWrt/AN1201L/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh
#默认打开WiFi
sed -i 's/disabled=1/disabled=0/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh
#修改时区
#sed -i "s/'UTC'/'CST-8'\n        set system.@system[-1].zonename='Asia\/Shanghai'/g" package/base-files/files/bin/config_generate

#加载config
[ -e ../config/Boos4721_an1201l.config ] && mv -f ../config/Boos4721_an1201l.config .config
