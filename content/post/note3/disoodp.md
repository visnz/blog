---
title: "跳出OO思想与OODP-杂记"
date: 2018-01-18
type: ["笔记"]
weight: 8
tags: ["编程思维","计算机"]
categories: ["笔记"]
description: "早期学习面向对象设计，不免遇到一些局限，偶然看到关于对OOP的一些反思与突破"
featuredImage: "https://visnonline.oss-cn-shenzhen.aliyuncs.com/pics/oldicon/oodp.jpg"
---

# 跳出面向对象思想
---
整理了一遍自己的笔记，里面有不少关于面向对象设计的内容，整理完放到了[Gitbook](https://visnz.gitbooks.io/ood-oodp/content/)，里面包括了**OO原则、二十三设计模式、跳出面向对象思想**三个部分。其中相对来说较为具有启发性的是第三部分的[跳出面向对象思想](https://visnz.gitbooks.io/ood-oodp/content/tiao-chu-mian-xiang-dui-xiang-si-xiang.html)，引用了来自大佬[Casa Taloyum博客](https://casatwy.com/)的三篇**跳出面向对象思想**。

更具体的关于面向对象思维的局限性可以见 [面向对象编程的弊端是什么？ - invalid s的回答 - 知乎](https://www.zhihu.com/question/20275578/answer/26577791)。

其最核心的问题在于，**在所有的编程设计都是辅助完成业务的前提下，不同的手段（面向过程、面向对象、面向函数等）能否尽力交付任务**。也不能否认面向对象思维给计算机带来的飞跃，在此基础上会有更先进的思维，这是大家愿意看到的。

## 关于设计模式
知乎的回答里业界大佬也以相对实际使用的角度提到了设计模式：“一切皆对象实质上是在鼓励堆砌毫无意义的喋喋不休，并且用这种战术层面都蠢的要命的喋喋不休来代替战略层面的考量。大部分人——注意，不是个别人——甚至被这种无意义的喋喋不休搞出了神经质，以至于非要在喋喋不休中找出意义：没错，我说的就是设计模式驱动编程，以及如此理解面向对象编程。”

承认其所提到的，“大家使用过度，反而忘记了设计的初衷”这一部分内容

作者原用于纠正“所以用面向对象语言写出来的东西一定更清晰、易懂”的误解（虽然我也比较同意），单独来说更偏向狭义上的设计模式；**[设计模式](https://www.wikiwand.com/zh-hans/%E8%AE%BE%E8%AE%A1%E6%A8%A1%E5%BC%8F)并非只存在于面向对象设计之中**，广义上是为所有的程序设计提供了解决方案的思路。

设计模式是一种抽象“抽象”的技术（或是艺术），[GoF设计模式](https://book.douban.com/subject/1052241/)一书具有划时代意义也在于它完成了对抽象逻辑的一次抽象，也给软件工程提供了一个不同角度的世界观和方法论。引用书中一段较为中肯的话

> 本书中涉及的设计模式并不描述新的或未经证实的设计，我们只收录那些**在不同系统中多次使用过的成功设计**。这些设计的绝大部分以往并无文本记录，它们或是来源于**面向对象设计者圈子里的非正式交流**，或是来源于某些成功的面向对象系统的某些部分，但对设计新手来说，这些东西是很难学得到的。尽管这些设计不包括新的思路，但我们**用一种新的、便于理解的方式将其展现给读者**，即：具有统一格式的、已分类编目的若干组设计模式。

而我们可能更需要注意的是避免一些问题，如

1. 只了解模式、不了解原因、场景
2. 过度设计、使用，忘记初衷问题


设计模式应当解决实际的问题，理论辅佐完成实践
设计模式应当变成一种行业内交流的货币，用于沟通交流


---
相关链接

1. [面向对象程序设计 - wiki](https://www.wikiwand.com/zh-hans/%E9%9D%A2%E5%90%91%E5%AF%B9%E8%B1%A1%E7%A8%8B%E5%BA%8F%E8%AE%BE%E8%AE%A1)
2. [知乎 - 面向对象编程的弊端是什么？](https://www.zhihu.com/question/20275578)
3. [知乎 - 设计模式有何不妥，所谓的荼毒体现在哪？](https://www.zhihu.com/question/23757237)
4. [知乎 - 如何正确地使用设计模式？](https://www.zhihu.com/question/23757906)
5. [Arch Linux 哲学](https://wiki.archlinux.org/index.php/Arch_Linux_(%E7%AE%80%E4%BD%93%E4%B8%AD%E6%96%87))
