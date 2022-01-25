#!/bin/bash
#=================================================
#   Description: DIY script
#   Lisence: MIT
#   Author: P3TERX
#   Blog: https://p3terx.com
#=================================================
#克隆源码
#git clone -b 21.02 --single-branch https://github.com/Lienol/openwrt openwrt
git clone -b 19.07 --single-branch https://github.com/Lienol/openwrt openwrt
#git clone -b openwrt-18.06 --single-branch https://github.com/immortalwrt/immortalwrt openwrt
cd openwrt
#添加passwall
sed -i '$a src-git xiaorouji https://github.com/xiaorouji/openwrt-passwall.git' feeds.conf.default
./scripts/feeds clean
./scripts/feeds update -a
./scripts/feeds install -a

#添加自定义插件
git clone https://github.com/ntlf9t/luci-app-easymesh package/luci-app-easymesh
#添加主题
git clone https://github.com/jerrykuku/luci-theme-argon.git package/luci-theme-argon-2.2.9
svn co https://github.com/kenzok8/openwrt-packages/trunk/luci-theme-edge package/luci-theme-edge
git clone https://github.com/jerrykuku/luci-theme-argon.git package/luci-theme-argon-1.7.2

#修改lan口地址
sed -i 's/192.168.1.1/192.168.10.1/g' package/base-files/files/bin/config_generate                                  
#修改机器名称
sed -i 's/OpenWrt/Newifi_Mini/g' package/base-files/files/bin/config_generate
#修改wifi名称
sed -i 's/OpenWrt/Newifi_Mini/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh
#默认打开WiFi
sed -i 's/disabled=1/disabled=0/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh
#修改时区
#sed -i "s/'UTC'/'CST-8'\n        set system.@system[-1].zonename='Asia\/Shanghai'/g" package/base-files/files/bin/config_generate

rm -rf package/base-files/files/etc/banner
cp -f ../banner-miwifi package/base-files/files/etc/banner
#加载config
#[ -e ../y1_lienol.config ] && mv -f ../y1_lienol.config .config
#[ -e ../y1-immortalwrt.config ] && mv -f ../y1-immortalwrt.config .config
[ -e ../y1-lienol-4.14.config.config ] && mv -f ../y1-lienol-4.14.config .config
