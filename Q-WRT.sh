#!/bin/bash
#=================================================
#   Description: DIY script
#   Lisence: MIT
#   Author: P3TERX
#   Blog: https://p3terx.com
#=================================================

git clone http://git.carystudio.cn/top-engine/Q-WRT.git openwrt
cd openwrt

#添加Lienol的插件包
sed -i '$a src-git xiaorouji https://github.com/xiaorouji/openwrt-passwall.git' feeds.conf.default
./scripts/feeds update -a
./scripts/feeds install -a

#添加主题
git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon.git package/luci-theme-argon-1.7.2

#修改lan口地址
#sed -i 's/192.168.1.1/192.168.10.1/g' package/base-files/files/bin/config_generate

#修改机器名称
#sed -i 's/OpenWrt/Newifi-Y1/g' package/base-files/files/bin/config_generate

#修改wifi名称
#sed -i 's/OpenWrt/FK20100010/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh
#默认打开WiFi
sed -i 's/disabled=1/disabled=0/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh

#修改时区
#sed -i "s/'UTC'/'CST-8'\n        set system.@system[-1].zonename='Asia\/Shanghai'/g" package/base-files/files/bin/config_generate

#修改插件位置
#sed -i 's/services/nas/g' package/lean/luci-app-samba4/luasrc/controller/samba4.lua
#修改zzz-default-settings的配置
#添加usbwan
#sed -i -e '/exit 0/{h;s/.*/cat ../config/add-usbwan/e;G}' package/default-settings/files/zzz-default-settings或
#sed  -i -e '/exit 0/r ../config/add-usbwan' -e 'x;$G' package/default-settings/files/zzz-default-settings

#添加简易网盘
#sed -i '/exit 0/i\mkdir -pv /srv/webd/web/.Trash\n' package/default-settings/files/zzz-default-settings
#sed -i '/exit 0/i\ln -sv /mnt/sda1 /srv/webd/web/U盘\n' package/default-settings/files/zzz-default-settings
#sed -i '/exit 0/i\chmod 775 /usr/bin/webd' package/default-settings/files/zzz-default-settings

#修改banner
rm -rf package/base-files/files/etc/banner
cp -f ../banner-y1 package/base-files/files/etc/banner
#[ -e ../files ] && mv ../files files
[ -e ../Q-WRT.config ] && mv ../Q-WRT.config .config
