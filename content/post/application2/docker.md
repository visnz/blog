---
title: "docker上手 生产环境本当大搬家"
date: 2018-12-16
type: ["应用"]
draft: true
weight: 7
tags: ["计算机","DOCKER"]
categories: ["运维"]
description: "拆分目录与备份，为自己创建docker生产环境"
featuredImage: "https://visnonline.oss-cn-shenzhen.aliyuncs.com/pics/docker/icon.png"
---

## 起因
帮 [viktorika的项目](https://github.com/visnz/Webserver) 学习打包的时候，写了个脚本手抖把个目录给删了，不得不重装系统，经过深思熟虑之后决定做以下三件事

1. 拆分``/home``、``/``

2. timeshift定期备份

3. 使用docker创建测试环境

## 拆分目录

意外~~怀孕~~炸机头疼莫过于平时丢在``/home/``里**杂乱的工作文件没有搜集起来**（特别是多人用户机系统崩溃时），所以不如直接把根目录拆分出来（根治），如debian安装引导的时候说的“高级玩法”

至于在``/etc``下**配置文件**以及多平台同步生产环境等问题：

- [ ] dotfile repo of mine ： setup require

- [x] 多平台生产环境：Chromium+[vscode setting sync](https://visnz.github.io/post/gists/)就是我的生产力

在重装系统的时候将原有的/dev/sdd3分割成40G跟175G

![](https://visnonline.oss-cn-shenzhen.aliyuncs.com/pics/docker/01.png)

按照原先的顺序先挂根目录到``/mnt``，再创建``/mnt/boot``、``/mnt/home``。

原本是想/var跟/usr跟/opt也一起拆了的，后来感觉分太多也麻烦没必要，杂乱文件也很多，毕竟每次出问题只格``/dev/sdd4``一件重装软件效果体验更佳（只要家在就行）

## TimeShift定期备份

用了一把梭打包TimeShift定期备份，还好系统不大，不然得活生生把根目录给吃掉

![](https://visnonline.oss-cn-shenzhen.aliyuncs.com/pics/docker/02.png)

TimeShift支持快照迁移到心的电脑上，在恢复快照之前，TimeShift会询问你是不是需要保存现有的应用设置，并且选择保存哪一个。TimeShift需要GRUB 2启动进入快照恢复。

一分钟不到就备份好了，不过没有尝试做容灾测试（可不敢手贱再把目录删一次了）

## 部署本地docker

1. ~~[什么是docker](https://www.zhihu.com/question/28300645)~~

2. ~~[为什么是docker](https://yeasy.gitbooks.io/docker_practice/introduction/why.html)~~

3. ~~[docker的基本使用](https://yeasy.gitbooks.io/docker_practice/content/)~~

一来是不直接在现有的环境上动手，风险也不小。

二是有通用的测试平台，有标准衡量与足够的试错机会。

```bash
# 换国内阿里云源
sudo echo '{"registry-mirrors": ["https://dftbcros.mirror.aliyuncs.com"]}'>>/etc/docker/daemon.json

# 启动服务
sudo systemctl daemon-reload && sudo systemctl enable docker --now

# 获取镜像
sudo docker pull debian
sudo docker pull ubuntu
```

由镜像创建实例：
```bash
# -d 守护进程 -i 交互模式 -t 虚拟终端 ，会返回已经创建的容器id
sudo docker run -dit ubuntu

# 使用attach进入容器，退出的时候会结束容器
sudo docker attach a1d

# 使用exec进入容器，退出的时候不会结束容器
sudo docker exec -it a1d bash
```
## 其他

因为拆分了home目录，如果遇上重装系统，大部分个人配置都还在，需要配置的是系统层面的配置，可以stow构建dotfile解决。
