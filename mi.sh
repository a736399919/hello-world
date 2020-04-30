#!/bin/bash
#=================================================
#   Description: DIY script
#   Lisence: MIT
#   Author: P3TERX
#   Blog: https://p3terx.com
#=================================================
git clone -b dev-19.07 https://github.com/Lienol/openwrt
cd openwrt
sed -i '/lienol/d' feeds.conf.default
sed -i '$a src-git lienol https://github.com/a736399919/lienol-openwrt-package' feeds.conf.default
./scripts/feeds clean
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
ln -s ../../luci-theme-argon1.x ./package/
ln -s ../../luci-app-flowoffload_ADGHome ./package/
#添加主题
git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon.git package/luci-theme-argon-1.5.1
rm -rf package/luci-theme-argon-1.5.1/htdocs/luci-static/argon/head-icon.jpg
rm -rf package/luci-theme-argon-1.5.1/htdocs/luci-static/argon/img/
cp -rf ../luci-theme-argon1.x/htdocs/luci-static/argon/head-icon.jpg package/luci-theme-argon-1.5.1/htdocs/luci-static/argon/
sed -i '/class="darkMask"/a \ \ \ <div class="login-bg" style="background-color: #5e72e4"></div>' package/luci-theme-argon-1.5.1/luasrc/view/themes/argon/header.htm
sed -i '/background-image/d' package/luci-theme-argon-1.5.1/luasrc/view/themes/argon/header.htm

git clone https://github.com/jerrykuku/luci-theme-argon.git package/luci-theme-argon-2.1
rm -rf package/luci-theme-argon-2.1/htdocs/luci-static/argon/head-icon.jpg
rm -rf package/luci-theme-argon-2.1/htdocs/luci-static/argon/img/
cp -rf ../luci-theme-argon1.x/htdocs/luci-static/argon/head-icon.jpg package/luci-theme-argon-2.1/htdocs/luci-static/argon/
sed -i '/class="darkMask"/a \ \ \ <div class="login-bg" style="background-color: #5e72e4"></div>' package/luci-theme-argon-2.1/luasrc/view/themes/argon/header.htm
sed -i '/background-image/d' package/luci-theme-argon-2.1/luasrc/view/themes/argon/header.htm
#修改lan口地址
sed -i 's/192.168.1.1/192.168.10.1/g' package/base-files/files/bin/config_generate

#修改机器名称
sed -i 's/OpenWrt/MIWIFI/g' package/base-files/files/bin/config_generate

#修改wifi名称
sed -i 's/OpenWrt/2010100010/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh
#默认打开WiFi
sed -i 's/disabled=1/disabled=0/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh

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
rm -rf .config
cp -f ../mi.config .config
