#!/bin/bash
#=================================================
#   Description: DIY script
#   Lisence: MIT
#   Author: P3TERX
#   Blog: https://p3terx.com
#=================================================
#克隆源码
git clone https://github.com/openwrt/openwrt.git openwrt
git clone https://github.com/coolsnowwolf/lede.git lede
cp -rf lede/package/lean/ openwrt/package/
cd openwrt
#添加Lienol的插件包
sed -i '$a src-git lienol https://github.com/Lienol/openwrt-package' feeds.conf.default
./scripts/feeds update -a
./scripts/feeds install -a

#添加主题
git clone https://github.com/jerrykuku/luci-theme-argon.git package/luci-theme-argon-2.2.5


#修改lan口地址
sed -i 's/192.168.1.1/192.168.10.1/g' package/base-files/files/bin/config_generate

#修改机器名称
sed -i 's/OpenWrt/MiWiFi/g' package/base-files/files/bin/config_generate

#默认打开WiFi
sed -i 's/disabled=1/disabled=0/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh

#修改wifi名称
sed -i 's/OpenWrt/MiWiFi/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh

#修改时区
#sed -i "s/'UTC'/'CST-8'\n        set system.@system[-1].zonename='Asia\/Shanghai'/g" package/base-files/files/bin/config_generate

#修改zzz-default-settings的配置
#sed -i '46,48d' package/lean/default-settings/files/zzz-default-settings
#sed -i '/exit 0/i\chmod 755 /etc/init.d/serverchan' package/lean/default-settings/files/zzz-default-settings
#sed -i '/exit 0/i\chmod 755 /usr/bin/serverchan/serverchan' package/lean/default-settings/files/zzz-default-settings
#sed -i '/exit 0/i\echo 0xDEADBEEF > /etc/config/google_fu_mode\n' package/lean/default-settings/files/zzz-default-settings

#修改banner
rm -rf package/base-files/files/etc/banner
cp -f ../banner-miwifi package/base-files/files/etc/banner
cp -f ../openwrt-miwifi.config .config

#把文件b的内容插到a的指定词(exit 0)的行前面
#sed -e '/exit 0/{h;s/.*/cat b.txt/e;G}' a
#sed  -e '/exit 0/r b' -e 'x;$G' a
#把文件b的内容插到a的指定词(exit 0)的行后面
#sed -e '/exit 0/{p;s/.*/cat b.txt/e;}' a
#sed 'exit 0/r b' a
