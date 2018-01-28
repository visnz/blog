---
title: "Archlinux 一把梭"
date: 2018-01-16
type: ["计算机"]
weight: 1
thumbnail: "pics/arch.png"
---

记录下平时可能会用到的（反正也是查阅用的）一把锁指令

**里面大多数是简单基础命令各位大神就不用看了**

# ~~同学你听过Archlinux吗~~没有

## Wifi热点

软件包：create_ap(community)

```
sudo create_ap <无线网卡>[<有线网卡>][<SSID>[<passwd>]]
```

找不到网卡就ifconfig
  - 软件包：net-tools(core)

## Unreal Engine 4

虚幻引擎在Windows上直接有引擎管理器，Linux上目前只能从github下载源码自己编译。（官方有贴[build on liunx](https://wiki.unrealengine.com/Building_On_Linux)的）。

感谢axionl大佬提醒**yaourt仓库里面有**，也是gitclone，只是文件太大自己网络状况也不是很理想（手动gitclone断流有点吃不消），可以直接下载zip

一些基础工具如``git etc.``自行安装，补安装``mono clang35 dos2unix cmake``

1. [UnrealEngine4](https://github.com/EpicGames/UnrealEngine)是隶属组织没有公开，加入组织fork一下
2. clone最新/**稳定**的版本`` git clone https://github.com/EpicGames/UnrealEngine.git``,大小接近两个G（后面放着没看了忘记具体多大了），也可以[指定版本](https://wiki.unrealengine.com/Building_On_Linux#Building)
3. 进入目录，依次执行``Setup.sh``，``GenerateProjectFiles.sh``检查构建环境
4. ``make UE4Editor-Linux-Debug``或直接``make``（睡觉去
5. 启动器位置：``./Engine/Binaries/Linux/UE4Editor``（如果刚刚执行``UE4Editor-Linux-Debug``的话是运行``UE4Editor-Linux-Debug``，其他类似）
6. 玩得开心

![](http://i1.sinaimg.cn/gm/2013/0607/U9866P115DT20130607160927.jpg)

可能出现的问题

- ``git clone``时候文件过大水管过小，断流会收到github的EOF，请保持网络通畅~~（为啥不直接打开网页下载呢）~~
- 请保持有**正确可用的平台环境**和**足够的计算性能和资源**，毕竟需要存储、检查、编译等
- 之前有一个版本直接就找不到对应库文件，编译时候各种爆炸
- 有一个版本跑完报ShaderCompileWorker 没有被编译
- 有些版本跑``make UE4Editor-Linux-Debug``没问题而``make``爆炸，也有反过来的。~~看脸~~
- 总之，有问题就把**滚包+换版本编译**

实在不行的朋友

1. 更换发行版，去debian受气
2. 更换操作系统，Windows老可爱了
3. 放弃使用UE4

## NTFS只读系统

软件包：ntfs-3g / ntfs-config(aur)

然后卸载+挂载 / reboom

## 设置开机启动ruijie…

ruijie的启动脚本（包括网卡启动）已经写好封装在``/usr/bin/goruijie``中

```sh
sudo touch /usr/lib/systemd/system/goruijie.service
```

service配置文件可见[鸟哥在gitbook的整理](https://wizardforcel.gitbooks.io/vbird-linux-basic-4e/content/150.html)

```
[Unit]
Description=Ruijie AutoSetup Service
After=network.target
Wants=network.target

[Service]
Type=simple
ExecStart=/usr/bin/goruijie
Restart=on-failure

[Install]
WantedBy=multi-user.target
```

刷新systemd、设置自动启动
```sh
sudo systemctl daemon-reload
sudo systemctl enable goruijie
```
