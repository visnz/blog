---
title: "Arch Linux 札记"
date: 2018-12-27
#date: 2018-01-20
type: ["笔记"]
weight: 1
tags: ["LINUX","计算机"]
categories: ["笔记","最近"]
description: "18年初入坑arch，当年不懂事又刷了别家。如今长大后悔了，我一定好好对待你"
featuredImage: "/pics/oldicon/arch.png"
---

记录下平时可能会用到的（查阅用）

---

# DNSMasq<sup>18.12.22</sup>

[DNSMasq](https://wiki.archlinux.org/index.php/Dnsmasq_(%E7%AE%80%E4%BD%93%E4%B8%AD%E6%96%87))服务使用本地做DNS缓存：``echo "listen-address=127.0.0.1" >> /etc/dnsmasq.conf``

添加本地解析：``/etc/resolv.conf``在最开头添加本地解析为最先

防止篡改：``sudo chattr +i /etc/resolv.conf``

配合create_ap组件给子网提供dns服务，在``/etc/dnsmasq.conf里``的``listen-address``中添加子网中的网关地址``127.0.0.1,10.0.0.1`` 

默认dnsmasq关闭了DHCP功能：<sup>18.12.26</sup>
```bash
# /etc/dnsmasq.conf
interface=<LAN-NIC>
bind-interfaces
dhcp-range=10.0.0.2,10.0.0.50,12h
dhcp-host=aa:bb:cc:dd:ee:ff,10.0.0.1
```

![](/pics/arch/01.png)

systemd图形化界面包``systemd-ui``<sup>18.12.21</sup>

dig所在软件包``dnsutils``<sup>18.12.20</sup>

## steam 冬季大促销<sup>18.12.19</sup>

泼皮买了个linux上能跑的，~~可爱，想玩~~

包名：steam steam-native-runtime(multilib)

报了找不到``~/.local/share/Steam/ubuntu12_32/steam-runtime/run.sh``的错

補了包：fontconfig lib32-fontconfig  nvidia-dkms nvidia-utils lib32-nvidia-utils

（nvidia与nvidia-dkms冲突，慎）

---

## libvirt虚拟机<sup>18.12.17</sup>

基于[KVM](https://wiki.archlinux.org/index.php/KVM_(%E6%AD%A3%E9%AB%94%E4%B8%AD%E6%96%87))，[libvirt](https://wiki.archlinux.org/index.php/Libvirt_(%E6%AD%A3%E9%AB%94%E4%B8%AD%E6%96%87))提供一系列虚拟机服务的集合（包括命令控制工具virsh、守护进程libvirtd）

virt-manager图形化界面<sup>18.12.29</sup>

依赖firewalld、ebtables、dnsmasq，安装后手动启动libvirtd、firewalld守护进程开始使用

libvirt没有载入default网络，位置在/etc/libvirt/qemu/networks/default.xml
``sudo virsh net-define /etc/libvirt/qemu/networks/default.xml``载入服务并重启守护进程。

``virsh net-autostart default``标记自动启动


## git 指定密钥登陆<sup>18.12.15</sup>

``./.ssh/config``

```bash
Host github.com
    HostName github.com
    IdentityFile ~/.ssh/$priviteKey
    User git

Host new.visn.online
    HostName new.visn.online
    IdentityFile ~/.ssh/archlinux
    Port 20069
    User visn

```

其中$priviteKey为登记在github setting中的公密钥对的密钥

## sshd端口修改<sup>18.12.13</sup>

指定端口：``echo 'Port=20069' >> /etc/ssh/sshd_config``

``systemctl daemon-reload && sudo systemctl restart sshd``

---

## 免密登陸<sup>18.11.31</sup>

1. 生成key pair: ``ssh-keygen -t rsa``默認會存儲在``~/.ssh/``下包含一個``id_rsa``/``id_rsa.pub``

2. 服務器獲取pubkey:

```bash
mkdir ~/.ssh ; touch ~/.ssh/authorized_keys && chmod 600 ~/.ssh/authorized_keys && chmod 700 ~/.ssh
echo [key_pub] >> ./authorized_keys
```

3. 同時可以用於github（需要以ssh方式clone）、各種遠程服務器實例的免密登陸

```bash
#!/bin/bash
useradd -m $1 && echo $1":"$1"8875" |chpasswd $1
mkdir /home/$1/.ssh ; touch /home/$1/.ssh/authorized_keys && chmod 600 /home/$1/.ssh/authorized_keys && chmod 700 /home/$1/.ssh
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


## fcitx in chromium & vscode
arch只裝了個最小包，安裝上fcitx後，生成配置文件

~/.xprofile
```bash
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS="@im=fcitx"
```

補上安裝：fcitx-qt4 fcitx-qt5 fcitx-gtk3 fcitx-gtk2 
KDE补上：kcm-fcitx

chromium vscode裏可以使用


---
# 18年11月28日及以前

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

1. 软件包：ntfs-3g（``sudo ntfs-3g /dev/sdb3 /mnt/test``）然后卸载+挂载 / logout

2. 因为在windows那边读取的时候存在一些失误操作导致无法写入，使用``ntfsfixboot``（aur）

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


