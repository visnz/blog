---
title: "sugou个人词库导入fcitx让输入法不再智障"
date: 2018-12-14
type: ["日常"]
weight: 6
tags: ["LINUX","计算机","tracert"]
categories: ["日常"]
description: "尝试一些看起来比较炫酷的工具（虽然并不知道意义何在）"
featuredImage: "/pics/ovtr/04.jpeg"
---
# 基本单元

词库的基本单元：编码、汉字、词频
> 如：gou'li'guo'jia'sheng'si'yi 苟利国家生死矣 233

次要结构如编码的分隔符（上例是``'``），换行符[^1]、单元间隔等等。

## 不同格式

搜狗拥有两个格式，scel与bin

搜狗细胞词库：scel :question:

搜狗个人用户词库：bin：二进制加密词库

fcitx引擎要求的词库格式为``mb``，一种二进制的词库格式

## 导入细胞词库scel

org是文本词库，基本格式如下：
> ai'hao'you'lai'luo'bi'nan 爱好由来落笔难
ai'min'sheng'zhi'duo'jian 哀民生之多艰
ai'shang'ceng'lou 爱上层楼
ai'zi'xin'wu'jin 爱子心无尽
an'an'sheng'tian'ji 黯黯生天际
an'bu'wang'wei 安不忘危
an'de'guang'sha'qian'wan'jian 安得广厦千万间


scel还有可以直接转换为mb词库的工具

## 导入个人词库bin

sogou输入法7.1版以后个人词库只道出bin格式

bin格式转换为其他格式：[深蓝词库转换](https://github.com/studyzy/imewlconverter)(>=2.4)，将其转换为org格式。

用org


导入到fcitx的词库中：mb格式

有scel直接转mb格式的工具：sg2fcitx [教程](http://www.mintos.org/skill/fcitx-sougou.html)

# tips

1. fcitx载入词库会一股脑全给挤进内存 :question:

2. ibus基于ibus-pinyin(>=1.3.0)使用sqlite格式的db[^2]，在DE可以使用``汉字 编码(') 词频``以文本格式导入

---
参考资料

1. [fcitx拼音输入法的搜狗细胞词库转换和导入教程](https://www.librehat.com/fcitx-sogou-pinyin-cell-database-convert-import-guide/)

2. [ibus-libpinyin可用32万txt词库](http://blog.dreamlikes.cn/archives/952)

[^1]: ``\r``是回车，``\n``是换行。具体区别追溯到打字机的基本结构。windows下每行结尾是``\n\r``，Unix是``\n``，Mac下是``\r``
[^2]: 瞄了一眼这个db格式不是很直观，有兴趣的旁有可以深入了解下
