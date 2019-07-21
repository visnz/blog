[![wercker status](https://app.wercker.com/status/f4b33e346f54874036e88db8d1cdc2d2/s/master "wercker status")](https://app.wercker.com/project/byKey/f4b33e346f54874036e88db8d1cdc2d2)

博客源文件存放处

主题、内容目录等在此修改（日常update

当前框架：
1. hexo：

- content源码

- pics图片（寄送到oss，由脚本同步）

2. 打包docker
- wercker使用archlinux安装hugo打包，多阶构建Nginx对外暴露web端口

2. ghpage：在[visnz.github.io](https://github.com/visnz/visnz.github.io)项目储存，由[https://visn.online](https://visn.online)访问