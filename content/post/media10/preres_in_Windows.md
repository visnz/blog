---
title: "FFmpeg+AnotherGUI实现Windows上进行ProRes 422编码"
date: 2018-05-21
type: ["影视"]
weight: 10
tags: ["计算机","影视","编码"]
thumbnail: "/pics/prores/ffmpeg.png"
---
## 方法来源

[How to Export Apple Pro Res on a PC Using Windows](https://www.youtube.com/watch?v=HcBHItw4niM)

## 材料

- [FFmpeg](https://ffmpeg.zeranoe.com/builds/)（[github地址](https://github.com/FFmpeg)）。官方提供了静态版（Static，无动态链接库）、共享库版（Shared）、构建版（Dev，一堆头文件）。此处下载Static或Shared版本

- [AnotherGUI](http://www.stuudio.ee/anothergui/)是一个编码器前端（高效并行处理），支持大量转码工作管理和调度。

- 一个基于H.264编码的视频，格式MOV、MP4等皆可

## 基本原理

把已经渲染好的基于H.264编码的视频，通过FFmpeg进行转码。AnotherGUI是一个图形界面操作者，协同管理和调度。

## 过程

- FFmpeg解压，执行文件``ffmpeg.exe``在``/bin``中
![](/pics/prores/01.png)

- AnotherGUI安装也是一把梭，画面简洁明了，常用英语
![](/pics/prores/02.png)

- AnotherGUI有指定FFmpeg，会在Path下寻找（但官方没找到Setup for Windows，会找不到），可以直接在Executables里重定向：
![](/pics/prores/03.png)
（注：第一次打开默认Path都是空白的，上图为过程演示）

- 转码模式选择
![](/pics/prores/04.png)

- 添加源文件（可直接拖拽），并在右边的输出文件夹选择
![](/pics/prores/06.png)

- Go
![](/pics/prores/07.png)

- 输出文件
![](/pics/prores/08.png)

直接用QQ影音（自我反省）打开听到一大堆撕裂声音，直接用QuickTime打开
![](/pics/prores/05.png)

## 结尾

貌似没有找到直接进行ProRes Encode in PC的方法…？（这就是FCP存在的理由吗？）

## 更多

- [DaVinci Resolve 穷人低配虚拟工作台](https://visnz.github.io/post/davinciresolve/)

- [pr素材代理 => 大素材打包分发剪辑 && 高计算量剪辑](https://visnz.github.io/post/video-proxy/)
