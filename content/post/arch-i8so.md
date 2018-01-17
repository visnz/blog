---
title: "Archlinux 一把梭"
date: 2018-01-16
weight: 10
draft: true
thumbnail: img/arch.jpg"
---

记录下平时可能会用到的（反正也是查阅用的）一把锁指令

**里面大多数是简单基础命令各位大神就不用看了**

# ~~同学你听过Archlinux吗~~没有

## Wifi热点

软件包：create_ap(community)

```
sudo create_ap <无线网卡>[<有线网卡>][<SSID>[<passwd>]]
```

- 找不到网卡跑跑ifconfig
  - 软件包：net-tools(core)

## Unreal Engine 4

虚幻引擎在Windows上直接有引擎管理器，Linux上目前只能从github下载源码自己编译。（官方有贴[build on liunx](https://wiki.unrealengine.com/Building_On_Linux)的）

一些基础工具如``git etc.``自行安装，补安装``mono clang35 dos2unix cmake``

1. [UnrealEngine4](https://github.com/EpicGames/UnrealEngine)是隶属组织没有公开，加入组织fork一下
2. clone最新/**稳定**的版本`` git clone https://github.com/EpicGames/UnrealEngine.git``,大小接近两个G（后面放着没看了忘记具体多大了），也可以[指定版本](https://wiki.unrealengine.com/Building_On_Linux#Building)
3. 进入目录，依次执行``Setup.sh``，``GenerateProjectFiles.sh``检查构建环境
4. ``make UE4Editor-Linux-Debug``或直接``make``一把锁（睡觉去
5. 启动器位置：``./Engine/Binaries/Linux/UE4Editor``及类似名
6. 玩得开心

![](./.src/pic/ue4.png)

可能出现的问题

- 之前有一个版本直接就找不到对应库文件
- 有一个版本跑完报ShaderCompileWorker 没有被编译

总之不行就把包滚到最新+换版本编译
