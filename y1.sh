#!/bin/bash
#=================================================
#   Description: DIY script
#   Lisence: MIT
#   Author: P3TERX
#   Blog: https://p3terx.com
#=================================================
#git clone https://github.com/coolsnowwolf/lede openwrt
git clone https://github.com/Lienol/openwrt.git
cd openwrt
#添加Lienol的插件包
#sed -i '$a src-git lienol https://github.com/Lienol/openwrt-package' feeds.conf.default
./scripts/feeds update -a
./scripts/feeds install -a
#添加自定义插件
#git clone https://github.com/Ameykyl/luci-app-koolproxyR.git package/luci-app-koolproxyR
#git clone https://github.com/tty228/luci-app-serverchan.git package/luci-app-serverchan
#git clone https://github.com/maxlicheng/luci-app-unblockmusic.git package/luci-app-unblockmusic
#git clone https://github.com/destan19/OpenAppFilter.git package/OpenAppFilter
#git clone https://github.com/Lienol/openwrt-package.git package/openwrt-package

#删除自带的插件
#rm -rf feeds/extra/luci-app-samba4
#rm -rf package/lean/luci-app-koolproxyR
#rm -rf package/lean/luci-app-serverchan
#rm -rf package/lean/luci-app-unblockmusic
#rm -rf package/lean/qBittorrent/Makefile
#rm -rf package/lean/qBittorrent/patches
#cp -f ../qb421 package/lean/qBittorrent/Makefile

#添加自己repo的插件的软连接
#ln -s ../../luci-theme-argon1.x ./package/
#ln -s ../../luci-app-flowoffload_ADGHome ./package/
#添加主题
git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon.git package/luci-theme-argon-1.7.0
#rm -rf package/luci-theme-argon-1.7.0/htdocs/luci-static/argon/head-icon.jpg
#rm -rf package/luci-theme-argon-1.7.0/htdocs/luci-static/argon/img/
#cp -rf ../luci-theme-argon1.x/htdocs/luci-static/argon/head-icon.jpg package/luci-theme-argon-1.7.0/htdocs/luci-static/argon/
#sed -i '/class="darkMask"/a \ \ \ <div class="login-bg" style="background-color: #5e72e4"></div>' package/luci-theme-argon-1.7.0/luasrc/view/themes/argon/header.htm
#sed -i '/background-image/d' package/luci-theme-argon-1.7.0/luasrc/view/themes/argon/header.htm

git clone https://github.com/jerrykuku/luci-theme-argon.git package/luci-theme-argon-2.2.5
#rm -rf package/luci-theme-argon-2.1/htdocs/luci-static/argon/head-icon.jpg
#rm -rf package/luci-theme-argon-2.1/htdocs/luci-static/argon/img/
#cp -rf ../luci-theme-argon1.x/htdocs/luci-static/argon/head-icon.jpg package/luci-theme-argon-2.1/htdocs/luci-static/argon/
#sed -i '/class="darkMask"/a \ \ \ <div class="login-bg" style="background-color: #5e72e4"></div>' package/luci-theme-argon-2.1/luasrc/view/themes/argon/header.htm
#sed -i '/background-image/d' package/luci-theme-argon-2.1/luasrc/view/themes/argon/header.htm
#修改lan口地址
sed -i 's/192.168.1.1/192.168.10.1/g' package/base-files/files/bin/config_generate

#修改机器名称
sed -i 's/OpenWrt/Newifi-Y1/g' package/base-files/files/bin/config_generate

#修改wifi名称
sed -i 's/OpenWrt/FK20100010/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh
#默认打开WiFi
sed -i 's/disabled=1/disabled=0/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh

#修改时区
#sed -i "s/'UTC'/'CST-8'\n        set system.@system[-1].zonename='Asia\/Shanghai'/g" package/base-files/files/bin/config_generate

#修改插件位置
#sed -i 's/services/nas/g' package/lean/luci-app-samba4/luasrc/controller/samba4.lua
#修改zzz-default-settings的配置
#添加usbwan
sed -e '/exit 0/{h;s/.*/cat ../config/add-usbwan/e;G}' package/default-settings/files/zzz-default-settings

#添加简易网盘
#sed -i '/exit 0/i\mkdir -pv /srv/webd/web/.Trash\n' package/default-settings/files/zzz-default-settings
#sed -i '/exit 0/i\ln -sv /mnt/sda1 /srv/webd/web/U盘\n' package/default-settings/files/zzz-default-settings
#sed -i '/exit 0/i\chmod 775 /usr/bin/webd' package/default-settings/files/zzz-default-settings

#修改banner
rm -rf package/base-files/files/etc/banner
cp -f ../banner-y1 package/base-files/files/etc/banner
#[ -e ../files ] && mv ../files files
[ -e ../lean-y1.config ] && mv ../lean-y1.config .config
