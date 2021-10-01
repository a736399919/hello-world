#!/bin/bash
#=================================================
#   Description: DIY script
#   Lisence: MIT
#   Author: P3TERX
#   Blog: https://p3terx.com
#=================================================

wget --no-check-certificate http://downloads.pangubox.com:6380/pandorabox/19.01/targets/ralink/mt7620/PandoraBox-SDK-ralink-mt7620_gcc-5.5.0_uClibc-1.0.x.Linux-x86_64-2018-12-31-git-4b6a3d5ca.tar.xz                                             
tar xvf PandoraBox-SDK-ralink-mt7620_gcc-5.5.0_uClibc-1.0.x.Linux-x86_64-2018-12-31-git-4b6a3d5ca.tar.xz
mv PandoraBox-SDK-ralink-mt7620_gcc-5.5.0_uClibc-1.0.x.Linux-x86_64-2018-12-31-git-4b6a3d5ca openwrt
git clone https://github.com/Boos4721/openwrt openwrt1
mv openwrt1/feeds.conf.default openwrt
mv openwrt1/package/lean openwrt/package/
cd openwrt

./scripts/feeds update -a
./scripts/feeds install -a
