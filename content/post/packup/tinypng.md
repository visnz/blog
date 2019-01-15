---
title: "TinyPNG初体验"
date: 2018-09-06
type: ["影视"]
weight: 16
tags: ["影视"]
thumbnail: "pics/tinypng/logo.jpg"
draft: true
---

## 背景
学习“数字图像处理”了解到使用TinyPNG对图片进行压缩，压缩比率能到50%以上

## TinyPNG
TinyPNG只是众多png压缩算法中的一种，相对优秀的还有pngquant/pngout
![QQ音乐技术团队分析](/pics/tinypng/5.jpg)

通过取出元数据、将RGB24位色压缩到索引8位色实现尽可能大的色彩保留
![](/pics/tinypng/3.png)

产品本身提供在线API、在线使用、以及TinyPNG可以作为PS插件整合等，相对灵活
![](/pics/tinypng/6.png)

## 测试
产品定位本身用于压缩较小的PNG图像（原理上建立索引颜色，通常不会用于处理复杂色彩图像）

用于图标等简单图案，TinyPNG压缩可以在肉眼较难感知情况下尽可能压缩
![](/pics/tinypng/2.png)

对于摄影作品的压缩就遇见比较大的问题
![](/pics/tinypng/1.png)

第一幅图的压缩率接近39%，第二幅图接近61%
![](/pics/tinypng/4.png)
跟画面内容跟画面信息都有关系（仅为单次测试，平均表现详见上面表格）

根据索引的原理压缩黑白图像可以尽可能多保存信息内容
摄影作品转换黑白后，用其压缩能得到不错的还原及大小压缩效果（38%）
![](/pics/tinypng/7.png)
![](/pics/tinypng/8.png)

## 简单结论

TinyPNG适合：

1. 图标、头像等压缩，降低软件安装包大小、加快网页交付

2. 摄影作品黑白图像的高质量、小空间存储（有损压缩）

3. 不适合色彩复杂的摄影作品存储

## 扩展

[python自动化批量处理TinyPNG脚本](https://blog.csdn.net/honjane/article/details/79288173)

[官网提供在线压缩尝试](https://tinypng.com/)

[QQ音乐技术团队对PNG图片压缩的分析](https://cloud.tencent.com/developer/article/1034208)

[附件：TinyPNG插件 for PS](/pics/tinypng/TinyPNG1.1.42.7z)
