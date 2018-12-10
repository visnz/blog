---
title: ""
date: 2018-12-07
type: [""]
weight: 1
tags: [""]
thumbnail: "/pics/ggj.png"
draft: true
---

## 文件系统

	Linux: ext3 ext4 xfs
## 目录结构
- 通常/作为根目录，/usr（用户软件库）,/home（用户家目录）,/var（服务目录）会单独规划。

- /boot   #系统启动需要的文件（内核）

- swap：
    - 内存<4G，设置二倍。
    - 内存>4G，swap分区大小等于物理内存。

## 工具使用
- 备份工具：``dump``备份 ``restore``恢复
- 打包工具：``tar/gzip/zcat/bzip2/compress/7z``
- C家工具：``gcc/g++``编译器``gdb``调试器

## 运维相关
- 例行工作：``crontab``（/etc/crontab）

    - 分 时 日 月 周（周和月、日调用有冲突）

    - ``* * * * * reboot``每分钟重启一次

    - ``*/2 * * * * reboot``每两分钟重启一次

    - ``20,50 9-20/3 * * * reboot``每天9到20点每三小时的20分，50分各执行一次

    - ``0 0 * * * pacman -Syu``每天自动滚包一次

## 基础使用
- ``&``丢后台

- ``... >/dev/null 2>&1 `` 丢弃 log 与错误

- 后台任务检查``jobs``任务管理器``ps/top/htop``

- 内存检查``free``

- 端口占用检查``netstat -anp|grep [port]``

## 桌面工具

- ``pitivi``：影片编辑软件
- ``shotwell``：图片管理器
- ``gimp``：Linux下的图片编辑工具（PS）
- ``gitkarken``：开源且免费的 git 可视化管理工具（官方推荐）

## 等待摸索
- [ ] vim

## 摘录

### 后台工作与服务
- 两种daemon的工作模式
    - super daemon：一个特殊的daemon，用于管理daemon监听和请求，接受到新请求，会向指定的daemon发起激活。通常用于响应大量的通用服务。
        - 多线程响应：一个服务对于多个服务进程，同时响应多个服务对象
        - 单线程响应：服务模型类似一个多路复用器。
    - stand alone：单独的一个持续运行的daemon，通常用于响应特殊服务。
        - 信号响应：一旦有信号就立即响应
        - 间隔响应：每隔一段时间响应。
- stand alone
  - ``/etc/services``记录着对大部分接口的服务监听。
  - ``/etc/init.d/``目录保存daemon启动脚本，stand alone启动
  - ``/etc/systemd/``各种服务的初始化环境配置文件
  - ``/etc/``各种服务的配置文件
  - ``/var/lib/``各服务产生数据的记录目录
  - service：对服务进行控制，替代对/etc/init.d/的控制
- super daemon
  - 该服务由xinetd管理，配置文件位于``/etc/xinetd.conf``（里面也记录面对同一个服务最多提供多少链接、面对同一个来源用户提供多少链接等信息）

### 进程管理
- ``fork()``创建子进程，0表示当前的子进程，大于0时为父进程PID，-1为创建失败
    - 函数调用一次单产生两个返回值，一个返回给子进程一个返回给父进程
  ```c
  pid=fork();
  if(!pid)printf("child process\n");
  else if(pid>0)printf("parent process\n");
  else printf("fork fail\n", );
  ```
 