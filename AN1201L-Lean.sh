#!/bin/bash
#=================================================
#   Description: DIY script
#   Lisence: MIT
#   Author: P3TERX
#   Blog: https://p3terx.com
#=================================================
#克隆源码
git clone https://github.com/coolsnowwolf/lede openwrt
cd openwrt
#添加passwall
sed -i '$a src-git xiaorouji https://github.com/xiaorouji/openwrt-passwall.git' feeds.conf.default
./scripts/feeds update -a
./scripts/feeds install -a

chmod 755 ../config/lean_02_network
mv ../config/lean_02_network target/linux/ramips/mt7621/base-files/etc/board.d/02_network
sed -i "s/xiaomi_mi-router-ac2100/cmcc_an1201l/g" `grep xiaomi_mi-router-ac2100 -rl target`
sed -i "s/Mi Router AC2100/AN1201L/g" `grep Mi Router AC2100 -rl target`
sed -i "s/mi-router-ac2100/an1201l/g" `grep mi-router-ac2100 -rl target`
sed -i "s/Xiaomi/CMCC/g" `grep Xiaomi -rl target`
sed -i "s/xiaomi/cmcc/g" `grep xiaomi -rl target`
cp target/linux/ramips/dts/mt7621_xiaomi_mi-router-ac2100.dts target/linux/ramips/dts/mt7621_cmcc_an1201l.dts
cp target/linux/ramips/dts/mt7621_xiaomi_router-ac2100.dtsi target/linux/ramips/dts/mt7621_cmcc_router-ac2100.dtsi
cp target/linux/ramips/dts/mt7621_xiaomi_nand_128m.dtsi target/linux/ramips/dts/mt7621_cmcc_nand_128m.dtsi
touch target/linux/*/Makefile

#添加自定义插件
svn co https://github.com/Lienol/openwrt-package/trunk/luci-app-fileassistant package/luci-app-fileassistan
git clone https://github.com/small-5/luci-app-adblock-plus.git package/luci-app-adblock-plus
git clone https://github.com/ntlf9t/luci-app-easymesh package/luci-app-easymesh
git clone https://github.com/KFERMercer/luci-app-tcpdump.git package/luci-app-tcpdump

#添加主题
svn co https://github.com/kenzok8/openwrt-packages/trunk/luci-theme-edge package/luci-theme-edge
git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon.git package/luci-theme-argon-1.7.2

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
#加载config
[ -e ../config/an1201l-lean.config ] && mv -f ../config/an1201l-lean.config .config
