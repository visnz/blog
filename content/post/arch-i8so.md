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

開關網卡 ``ip link set enp40s0 up``

``sudo create_ap <无线网卡>[<有线网卡>][<SSID>[<passwd>]]``
or

config file: /etc/create_ap.conf
``sudo systemctl enable/start create_ap``

銳捷每一分鐘心跳檢查一次多網卡，``crontab -e``不支持秒級，用了個蠢辦法

```bash
* * * * * /home/visn/rjsupplicant/rjsupplicant.sh -d 1 -u 1500000000 -p 123456 -n enp4s0 >> /var/log/rjs.log
* * * * * sleep 10; /home/visn/rjsupplicant/rjsupplicant.sh -d 1 -u 1500000000 -p 123456 -n enp4s0 >> /var/log/rjs.log
* * * * * sleep 20; /home/visn/rjsupplicant/rjsupplicant.sh -d 1 -u 1500000000 -p 123456 -n enp4s0 >> /var/log/rjs.log
* * * * * sleep 30; /home/visn/rjsupplicant/rjsupplicant.sh -d 1 -u 1500000000 -p 123456 -n enp4s0 >> /var/log/rjs.log
* * * * * sleep 40; /home/visn/rjsupplicant/rjsupplicant.sh -d 1 -u 1500000000 -p 123456 -n enp4s0 >> /var/log/rjs.log
* * * * * sleep 50; /home/visn/rjsupplicant/rjsupplicant.sh -d 1 -u 1500000000 -p 123456 -n enp4s0 >> /var/log/rjs.log
```

## NTFS只读系统

1. 软件包：ntfs-3g / ntfs-config(aur)

2. 然后卸载+挂载 / logout

## 藍牙音響

1. 安裝基本藍牙包：bluez 和 bluez-utils

``sudo systemctl enable/start bluetooth``

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

## 雜

- archlinux pacman db : ``/var/lib/pacman/db.lck``

- [archlinux 啓動未引導而進入grub解決方法](https://www.openfoundry.org/tw/foss-programs/9267-linux-grub2-fixing)，寫入：`` sudo grub-mkconfig -o /boot/grub/grub.cfg``

- arch 使用 cronie(systemd) 管理計劃任務（disable），可以使用``crontab -e``編輯文件。三連擊``daemon-reload enable restart``

