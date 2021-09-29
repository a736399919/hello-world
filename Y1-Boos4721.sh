sed -i 's/5.4/5.10/g' target/linux/ipq40xx/Makefile
#!/bin/bash
#=================================================
#   Description: DIY script
#   Lisence: MIT
#   Author: P3TERX
#   Blog: https://p3terx.com
#=================================================
#克隆源码
git clone https://github.com/Boos4721/openwrt openwrt
sed -i 's/5.4/5.10/g' openwrt/target/linux/ramips/Makefile
[ -e files ] && mv files openwrt/files
cd openwrt
./scripts/feeds update -a
./scripts/feeds install -a -f

#添加主题
git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon.git package/luci-theme-argon-1.7.2

#修改lan口地址
sed -i 's/10.10.10.1/192.168.10.1/g' package/base-files/files/bin/config_generate
#修改机器名称
sed -i 's/OpenWrt/Newifi-Y1/g' package/base-files/files/bin/config_generate
#修改wifi名称
sed -i 's/OpenWrt_2.4G/Newifi-Y1/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh
sed -i 's/OpenWrt/Newifi-Y1/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh
#默认打开WiFi
sed -i 's/disabled=1/disabled=0/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh
#修改时区
#sed -i "s/'UTC'/'CST-8'\n        set system.@system[-1].zonename='Asia\/Shanghai'/g" package/base-files/files/bin/config_generate
#修改zzz-default-settings的配置
#修改网络共享的位置
sed -i "/exit 0/i\sed -i 's/services/nas/g' /usr/lib/lua/luci/controller/samba4.lua" package/lean/default-settings/files/zzz-default-settings
#修改aria2的位置
sed -i "/exit 0/i\sed -i 's/services/nas/g' /usr/lib/lua/luci/controller/aria2.lua" package/lean/default-settings/files/zzz-default-settings
#修改oaf的位置
sed -i "/exit 0/i\sed -i 's/network/control/g' /usr/lib/lua/luci/controller/appfilter.lua" package/lean/default-settings/files/zzz-default-settings
#添加简易网盘
sed -i '/exit 0/i\mkdir -pv /srv/webd/web/.Trash' package/lean/default-settings/files/zzz-default-settings
sed -i '/exit 0/i\ln -sv /mnt/sda1 /srv/webd/web/U盘' package/lean/default-settings/files/zzz-default-settings
sed -i '/exit 0/i\chmod 775 /usr/bin/webd\n' package/lean/default-settings/files/zzz-default-settings

#修改banner
rm -rf package/base-files/files/etc/banner
cp -f ../banner-y1 package/base-files/files/etc/banner
[ -e ../Y1-Boos4721*.config ] && mv ../Y1-Boos4721*.config .config
