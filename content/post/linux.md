---
title: "Linux 筆記大整理"
date: 2018-12-07
type: ["計算機"]
weight: 1
tags: ["計算機","Linux","手冊"]
thumbnail: "pics/linux/icon.png"
---

## 基本工具

1. ``df``、``fdisk``、``fdisk``等基本硬盤查看工具

2. ls：基本是自帶``--color=auto``這個地燈設置。
 
    - ``-al``列出隱藏與詳細信息
    
    - ``-Csh``着色、大小顯示
 
    - ``-R``超詳細目錄信息

### 文件操作

1. 文件时间：使用touch更新文件三个时间，可以用于获取新的sshkey

    - mtime：内容修改时间

    - ctime：权限修改时间

    - atime：文件访问时间

2. 命令位置查詢：``whereis``（比find快，比which多）

3. 文件類型：``file``

4. find：全盘查找工具``sudo find / -name "hello.*"``

    - -name [regex]

    - -size +50k

    - -type d目录、p管道等

    - -perm 模式

## shell腳本

1. 判斷文件夾是否存在，若存在並進入``[ $1 ] && cd $1``

2. 判斷文件是否存在，不存在則創建``if [ ! -f $1 ];then `touch $1` fi``

2. 羣組變量：``sites1=("163.com" "ustc.edu.cn" "aliyun.com")``聚合羣組變量：``all=(${sites1[@]} ${sites2[@]})``

3. 遍歷./文件：``for var in `ls -1` do ... done``

## 雜七雜八工具使用

1. 樹狀圖展示，僅展開1層``tree -L 2``

    - ``-sh``附帶大小

    - ``-p``附帶權限
 
    - ``-P [regex]``只顯示適配文件（會包含文件夾）

    - ``-C``色彩表示

## git
1. ``git config --global user.`` 設置用戶信息

## 其他探索
### 虛擬機
``qemu``、``xen``、``kvm``


## 運維相關

1. 用戶登錄信息：``last``

2. 查看-修改時區：``date -R; ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime``

3. 查看網卡信息：``cat /proc/net/dev``

4. 實時滾動的log：``tail -f [file]`` 

5. 魂歸垃圾桶：`` >/dev/null 2>&1``


