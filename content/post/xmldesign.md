---
title: "null"
date: 2018-01-17
draft: true
---
xml：描述属性文件的层次，避免二义性和全局唯一，减轻解析工作

混合式加重解析工作比如
```xml
<font>
  Times
  <size>36</size>
</font>
```

引入了属性来方便描述
```xml
<font name="Times" size="36 pt"/>
```

但属性应该用来修改对值的解释而不是指定值

如上面应该改成
```xml
<font>
  <name>Times</name>
  <size unit="pt">36</size>
</font>
```
