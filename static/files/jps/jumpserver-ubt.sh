#!/bin/bash
# this script was installation of jumpserver in ubuntu 18.04
# ref: http://docs.jumpserver.org/zh/docs/setup_by_ubuntu.html
Server_IP='' 
# fill the Server_IP with IPv4
jumpserver_path='/opt/jumpserver/'

file='./backup'
# this file as tempfile to save the passwd which generating by random:
if [ -f $file ]; then 
    DB_PASSWORD=`cat $file|grep DB_PASSWORD|cut -d ' ' -f 2`
    SECRET_KEY=`cat $file|grep SECRET_KEY|cut -d ' ' -f 2`
    BOOTSTRAP_TOKEN=`cat $file|grep BOOTSTRAP_TOKEN|cut -d ' ' -f 2`
else
    DB_PASSWORD=`cat /dev/urandom | tr -dc A-Za-z0-9 | head -c 24`      # 生成随机数据库密码      
    SECRET_KEY=`cat /dev/urandom | tr -dc A-Za-z0-9 | head -c 50`       # 生成随机SECRET_KEY       
    BOOTSTRAP_TOKEN=`cat /dev/urandom | tr -dc A-Za-z0-9 | head -c 16`  # 生成随机BOOTSTRAP_TOKEN 
    echo "DB_PASSWORD $DB_PASSWORD" > $file
    echo "SECRET_KEY $SECRET_KEY" >> $file
    echo "BOOTSTRAP_TOKEN $BOOTSTRAP_TOKEN" >> $file
fi

apt update && apt -y upgrade 
apt -y install wget gcc libffi-dev git python-pip language-pack-zh-hans  mysql-server libmysqlclient-dev python3-pip python3-dev python3-venv  redis-server

## redis 修正
sed -i "s/bind 127.0.0.1 ::1/bind 127.0.0.1/g" /etc/redis/redis.conf 
sudo systemctl restart redis-server.service 


echo 'LANG="zh_CN.utf8"' > /etc/default/locale
export LC_ALL="zh_CN.utf-8"
echo '基本软件安装完成'
echo ' 回车以继续 '
mysql -u root -p -e "create database jumpserver default charset 'utf8'; grant all on jumpserver.* to 'jumpserver'@'127.0.0.1' identified by '$DB_PASSWORD'; flush privileges;"

# 进入虚拟环境
python3 -m venv /opt/py3
source /opt/py3/bin/activate

# jumpserver下载与依赖安装
mkdir $jumpserver_path/
git clone https://github.com/jumpserver/jumpserver.git $jumpserver_path/
# 此处用于获取依赖列表，列表随git更新
apt-get -y install `cat $jumpserver_path/requirements/deb_requirements.txt`

pip3 install --upgrade setuptools 
pip3 install wheel
# 使用此处时候发生wheel相关缺失
pip3 install -r $jumpserver_path/requirements/requirements.txt 



cp $jumpserver_path/config_example.yml $jumpserver_path/config.yml
sed -i "s/SECRET_KEY:/SECRET_KEY: $SECRET_KEY/g" $jumpserver_path/config.yml
sed -i "s/BOOTSTRAP_TOKEN:/BOOTSTRAP_TOKEN: $BOOTSTRAP_TOKEN/g" $jumpserver_path/config.yml
sed -i "s/# DEBUG: true/DEBUG: false/g" $jumpserver_path/config.yml
sed -i "s/# LOG_LEVEL: DEBUG/LOG_LEVEL: ERROR/g" $jumpserver_path/config.yml
sed -i "s/# SESSION_EXPIRE_AT_BROWSER_CLOSE: false/SESSION_EXPIRE_AT_BROWSER_CLOSE: true/g" $jumpserver_path/config.yml
sed -i "s/DB_PASSWORD: /DB_PASSWORD: $DB_PASSWORD/g" $jumpserver_path/config.yml


# 启动服务器
$jumpserver_path/jms start all -d 




# 对外接口
apt-get -y install apt-transport-https ca-certificates curl software-properties-common
curl -fsSL http://mirrors.aliyun.com/docker-ce/linux/ubuntu/gpg | sudo apt-key add -
add-apt-repository "deb [arch=amd64] http://mirrors.aliyun.com/docker-ce/linux/ubuntu $(lsb_release -cs) stable"
apt-get -y update
apt-get -y install docker-ce
curl -sSL https://get.daocloud.io/daotools/set_mirror.sh | sh -s http://f1361db2.m.daocloud.io
systemctl restart docker.service

## 部署 Coco
docker pull jumpserver/jms_coco
docker run --name jms_coco -d -p 2222:2222 -p 5000:5000 -e CORE_HOST=http://$Server_IP:8080 -e BOOTSTRAP_TOKEN=$BOOTSTRAP_TOKEN jumpserver/jms_coco
# BOOTSTRAP_TOKEN 为 Jumpserver/config.yml 里面的 BOOTSTRAP_TOKEN

## Guacamole
docker pull jumpserver/jms_guacamole
docker run --name jms_guacamole -d -p 8081:8081 -e JUMPSERVER_SERVER=http://$Server_IP:8080 -e BOOTSTRAP_TOKEN=$BOOTSTRAP_TOKEN jumpserver/jms_guacamole

##  Luna
wget https://github.com/jumpserver/luna/releases/download/1.4.8/luna.tar.gz
mv luna.tar.gz /opt/luna.tar.gz
tar -zxvf /opt/luna.tar.gz
chown -R root:root /opt/luna

## Nginx
apt-get -y install curl gnupg2 ca-certificates lsb-release
add-apt-repository "deb http://nginx.org/packages/ubuntu/ $(lsb_release -cs) nginx"
curl -fsSL http://nginx.org/keys/nginx_signing.key | sudo apt-key add -
apt-get -y install nginx

rm -rf /etc/nginx/conf.d/default.conf
# touch /etc/nginx/conf.d/jumpserver.conf
mv ./nginx.conf /etc/nginx/nginx.conf 

nginx -t  # 如果没有报错请继续
systemctl restart nginx

echo -e "\033[31m 你的jumpserver数据库密码是 $DB_PASSWORD \033[0m"
echo -e "\033[31m 你的SECRET_KEY是 $SECRET_KEY \033[0m"
echo -e "\033[31m 你的BOOTSTRAP_TOKEN是 $BOOTSTRAP_TOKEN \033[0m"
echo -e "\033[31m 请记得检查 $jumpserver_path/config.yml 文件\033[0m"
echo -e "\033[31m 你的服务器IP是 $Server_IP \033[0m"



## 重启后的执行
# python环境
## source /opt/py3/bin/activate
# 启动容器
## docker container ls -a|grep jms_guacamole|cut -c 1-15|xargs docker start
## docker container ls -a|grep jms_coco|cut -c 1-15|xargs docker start
# 启动主服务
## /opt/jumpserver/jms start all -d 