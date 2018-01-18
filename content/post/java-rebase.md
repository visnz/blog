---
title: "Java Rebase"
date: 2018-01-18
draft: true
type: ["计算机"]
menu:
  main:
    name: "计算机"
weight: 10
tags: ["Java","计算机"]
thumbnail: "http://blog.experts-exchange.com/wp-content/uploads/2012/02/java1.jpg"
---

# 写在前面
---

## Java囧境

作为面向对象炒得最火的语言，Java曾依靠虚拟机的跨平台特性撑起计算机半臂江山。

时至今日，Java已经略显疲惫，有些高不成低不就的感觉。

1. 试图培养成一种面向通用的语言，在py、R、Go等面向专业语言诞生之后，java的通用优势不足。
	1. 在安卓领域，第二代第三代JVM语言横空出世，Kotlin快速夺取市场。
	2. 在服务器领域，因为历史遗留问题JavaSRE目前依然为主流，但不是长久之计。新的服务器架构快速迭代，后起之秀Py、nodejs也在快速增长。
	3. 桌面领域Java一直有力使不出来，底部依赖大、自家GUI又刚不过qt系列
	4. 语言语法及其体系相对冗长、功能迭代速度相对较慢，底层相对重量级
2. 甲骨文的收购、商业化与闭源一定程度上延迟了技术层面的增长
3. 曾经的跨平台特性已经不再是其核心竞争力
4. Java的体系相当庞大，光是服务器框架就可以学完大学四年

（其实感觉有点像[Apache与Nginx port80之争](https://linux.cn/article-8292-1.html)那份漫画，老一辈与晚辈各自的优势）

**刚刚所提的这些点不是贬低Java，是较为理性地描述面临的问题**

## 个人发展瓶颈

本身自己是学习Java内容居多的，从高中一本《从如坑到弃疗》，到大学起来接触各种教新的技术。

**大学生迷茫直观上来说，无非分为两种**

- 了解得太少
- 了解得太多

中学的时候不知道java是什么，一直摇摆不定学不学计算机，特迷茫。报考了志愿进了计算机这一大坑，诶，目标算是定下来了，不会太迷茫，java就继续学下去。直到接触了更多更先进的技术，再次陷入迷茫。

[《断舍离》](https://book.douban.com/subject/24749465/)提供了一些方法论来解决问题，做出了自己的决定：放弃java，转向其他语言

上升到另一个层面，变成语言无非只是解决问题的方法而以，所以这个决定并不是什么大事。我现在要做的是把大学这一两年来断断续续学到的Java的内容进行归纳总结，**毕竟编程设计语言是具有共性的，在Java学到的解决问题的思路，完全可以应用到其他语言、学科和领域**。所以在此开了这篇文章。

所以标题引用了git中一个专业名词**Rebase**，更直观的感受是**更换基底**的意思。

# Java总览
---
语言特性

- 面向对象（封装继承多态，不允许多重继承）
- 跨平台(once code, run everywhere)
- 底层解释型（机器码）
- 安全检查（你可能需要Rust）
- 内存垃圾gc
- 大小写严格、默认驼峰命名法

## 技术与名词

JVM(Java Virtual Machine) Java实体运行软件，通过编程Java代码，编译成class机器码，由JVM适配平台，执行机器码内容（以此实现跨平台）。当然，JVM不一定由Java编写，使用Ruby语言+JRuby编译器等照样可以调用JVM。具体的计算机程序编译过程请自行了解。

JRE(Java Runtime Environment)Java运行环境，包含一个JVM和一系列标准类库

JDK(Java Development Kit) 程序开发库，包含了接口等一系列开发必备软件，通过Java语法导入、调用

JDK的实体文件结构

|目录|描述|
|-|-|
| \bin| 编译器、测试与调用等工具|
| \demo| 代码示例|
| \docs| html的类库文档|
| \include| 用于编译本地库、本地方法的文件|
| \jre|运行环境所需的文件|
| \lib|类库文件|
| \src|类库源文件|


SE、ME、EE Java的三个不同版本，分别对应小型设备、桌面与简单服务器、企业及服务器三种平台

JavaBean

EJB(Enterprise JavaBean)

POJO(Plain Ordinary Java Object)









---
参考资料

1. [Core Java™ Volume I Fundamentals. (Ninth Edition)](https://www.amazon.com/Core-Java-I-Fundamentals-9th/dp/0137081898)

2. [Core Java™ Volume II Fundamentals. (Ninth Edition)](https://www.amazon.com/Core-Java-II-Advanced-Features-9th/dp/013708160X)

3. [Thinking in Java (4th Edition)](https://www.amazon.com/Thinking-Java-4th-Bruce-Eckel/dp/0131872486)

4. [Github: jobbole/awesome-java-cn](https://github.com/jobbole/awesome-java-cn)

5. [Github: google/guava](https://github.com/google/guava)

6. [google/guava 翻译学习支持](http://ifeve.com/google-guava/)

7. [Gitbook 阿里巴巴Java开发手册](https://goghtsui.gitbooks.io/-java/content/)

8. [如何评价阿里近期发布的Java编码规范？ - 知乎](https://www.zhihu.com/question/55642203)
