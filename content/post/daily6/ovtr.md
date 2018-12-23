---
title: "OVTR 視覺化tracert 日好幾把炫酷（然並卵）"
date: 2018-12-14
type: ["日常"]
weight: 6
tags: ["LINUX","计算机","tracert"]
thumbnail: "pics/ovtr/04.jpeg"
---

## 開始

在某大佬博客~~（忘了哪位）~~看到用ping且召喚出了地圖可視化，大概是像這種

![](/pics/ovtr/03.png)[^1]

感覺：

![](/pics/ovtr/02.jpg)


一路找下來發現一款好老的開源軟件[Open  Visual  Traceroute](https://visualtraceroute.net/)（基於Java、[MAXMIND GeoIP2 DB](https://www.maxmind.com/en/home)）

在線追蹤的可以使用[IPIP](https://tools.ipip.net/traceroute.php)可以選擇全球300多線路發送ICMP tracert測試

![](/pics/ovtr/05.png)

## 安裝
``archlinuxcn/openvisualtraceroute``，安裝後可以在菜單裏找到相應名字

![](/pics/ovtr/01.png)

由於第一次使用需要初始化GeoIP DB，不知道是否線路問題無法下載

命令行代理啓動``sudo proxychains ovtr``初始化DB，以後就在Desktop啓動就OK啦

![](/pics/ovtr/06.png)

Enjoy！

[^1]: http://www.mantingfeng.com/?p=618