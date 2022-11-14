#!/bin/bash
#=================================================
#   Description: DIY script
#   Lisence: MIT
#   Author: P3TERX
#   Blog: https://p3terx.com
#=================================================
#克隆源码
#git clone -b openwrt-18.06-k5.4 --single-branch https://github.com/immortalwrt/immortalwrt openwrt
git clone -b openwrt-21.02 --single-branch https://github.com/immortalwrt/immortalwrt openwrt
cd openwrt
./scripts/feeds update -a
./scripts/feeds install -a

mv ../config/immortalwrt_mt7621_youhua_wr1200js.dts target/linux/ramips/dts/mt7621_youhua_wr1200js.dts
mv ../config/immortalwrt_02_network target/linux/ramips/mt7621/base-files/etc/board.d/02_network
#更改主机型号，支持中文。 
sed -i "s/YouHua WR1200JS/CMCC_AN1201L/g" target/linux/ramips/dts/mt7621_youhua_wr1200js.dts

#添加自定义插件
git clone https://github.com/ntlf9t/luci-app-easymesh package/luci-app-easymesh
git clone https://github.com/KFERMercer/luci-app-tcpdump.git package/luci-app-tcpdump

#添加主题
git clone https://github.com/thinktip/luci-theme-neobird.git package/luci-theme-neobird
svn co https://github.com/kenzok8/openwrt-packages/trunk/luci-theme-edge package/luci-theme-edge
git clone https://github.com/jerrykuku/luci-theme-argon.git package/luci-theme-argon-1.7.2
git clone https://github.com/jerrykuku/luci-theme-argon.git package/luci-theme-argon-2.2.9

#修改lan口地址
#sed -i 's/192.168.1.1/192.168.31.1/g' package/base-files/files/bin/config_generate                                  
#修改机器名称
sed -i 's/OpenWrt/AN1201L/g' package/base-files/files/bin/config_generate
#修改wifi名称
sed -i 's/ImmortalWrt/AN1201L/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh
#默认打开WiFi
sed -i 's/disabled=1/disabled=0/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh
#修改时区
#sed -i "s/'UTC'/'CST-8'\n        set system.@system[-1].zonename='Asia\/Shanghai'/g" package/base-files/files/bin/config_generate

#加载config
mv -f ../config/immortalwrt_an1201l.config .config
