---
title: "Archlinux 簡單記錄"
date: 2018-11-28
type: ["计算机"]
weight: 1
tags: ["Linux","计算机"]
thumbnail: "pics/arch.png"
---

记录下平时可能会用到的（查阅用）

## hostap+ruijie

软件包：create_ap(community)

查詢網卡 ifconfig ：net-tools(core)

``sudo create_ap <无线网卡>[<有线网卡>][<SSID>[<passwd>]]``
or

config file: /etc/create_ap.conf
``sudo systemctl enable create_ap``
``sudo systemctl start create_ap``

```bash
#!/bin/bash
# file in /usr/bin/rj.sh
while true
do
        ~/rjsupplicant/rjsupplicant.sh -d 1 -u [studentID] -p [passwd] -n [nic] &
        sleep 5
done
```
then run ``sudo echo "" && rj.sh >/dev/null 2>&1 &``

## NTFS只读系统

1. 软件包：ntfs-3g / ntfs-config(aur)

2. 然后卸载+挂载 / logout

## 藍牙音響

1. 安裝基本藍牙包：bluez 和 bluez-utils

``sudo systemctl enable bluetooth``
``sudo systemctl start bluetooth``

2. 協議無法識別 出現： a2dp-sink profile connect failed  Protocol not available 安裝 pulseaudio-bluetooth

3. 重啓PulseAudio server & Bluetooth生效
```bash
killall pulseaudio
pulseaudio --start
systemctl restart bluetooth
```

---
18年11月28日後再填大坑

## 免密登陸

1. 生成key pair: ``ssh-keygen -t rsa``默認會存儲在``~/.ssh/``下包含一個``id_rsa``/``id_rsa.pub``

2. 服務器獲取pubkey:

```bash
mkdir ~/.ssh || touch ~/.ssh/authorized_keys && chmod 600 ~/.ssh/authorized_keys && chmod 700 ~/.ssh
echo [key_pub] >> ./authorized_keys
```

3. 同時可以用於github（需要以ssh方式clone）、各種遠程服務器實例的免密登陸

```bash
#!/bin/bash
useradd -m $1 && echo $1":"$1"8875" |chpasswd $1
mkdir /home/$1/.ssh || touch /home/$1/.ssh/authorized_keys && chmod 600 /home/$1/.ssh/authorized_keys && chmod 700 /home/$1/.ssh
chown $1:$1 /home/$1/.ssh/authorized_keys
chown $1:$1 /home/$1/.ssh
echo $2 >> /home/$1/.ssh/authorized_keys
```

## uget

[瀏覽器插件](https://chrome.google.com/webstore/detail/uget-integration/efjgjleilhflffpbnkaofpmdnajdpepi)

``sudo pacman -S uget uget-integrator-chrome uget-integrator-chromium``
