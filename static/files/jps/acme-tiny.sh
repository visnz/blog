#!/bin/bash

echo '请确保80端口可用'

if [ $(id -u) != "0" ]; then
    echo "非Root用户 "
    exit 1
fi
# 请配置您的域名
YOUR_DOMAIN=""
DIR="/var/www/httpssl/acme-tiny"
NGINX_CONF='/etc/nginx/nginx.conf'

if [ -z "$YOUR_DOMAIN" ]; then
    read -p "域名为空，请填写" YOUR_DOMAIN
    echo "域名：$YOUR_DOMAIN"
fi

if [ ! -f $DIR/chained.pem ];then
    echo "找不到 $DIR/chained.pem 开始注册证书"

    apt update -y;apt install  -y mlocate openssl git nginx
    echo '更新本机软件完毕'
    mkdir -p $DIR && git clone https://github.com/diafygi/acme-tiny.git $DIR/
    echo '拉取acme-tiny'
    ## 创建CSR
    # 创建一个 Let's Encrypt账户私钥，以便让其识别你的身份
    openssl genrsa 4096 > $DIR/account.key
    # 创建域名证书请求文件(CSR)
    openssl genrsa 4096 > $DIR/domain.key
    openssl req -new -sha256 -key $DIR/domain.key -subj "/" -reqexts SAN -config <(cat `updatedb ;locate openssl.cnf|grep usr` <(printf "[SAN]\nsubjectAltName=DNS:$YOUR_DOMAIN")) > $DIR/domain.csr

    # 临时替换 nginx 配置
    mv $NGINX_CONF $NGINX_CONF.bak
    echo "events{}http{server{listen 80; server_name $YOUR_DOMAIN;location /.well-known/acme-challenge/ {
            alias $DIR/;
        }}}">$NGINX_CONF
    systemctl reload nginx;
    nginx -t && echo "nginx 临时配置完成"

    python $DIR/acme_tiny.py --account-key $DIR/account.key --csr $DIR/domain.csr --acme-dir $DIR/ > $DIR/signed.crt
    ## 此时得到证书 signed.crt
    mv $NGINX_CONF.bak $NGINX_CONF
    systemctl reload nginx;
    nginx -t && echo "nginx 配置恢复完成"

    wget -O - https://letsencrypt.org/certs/lets-encrypt-x3-cross-signed.pem > $DIR/intermediate.pem 
    cat $DIR/signed.crt $DIR/intermediate.pem > $DIR/chained.pem

    echo '已生成 $DIR/chained.pem 与 $DIR/domain.key'

    # 注册事件
    chmod +x `pwd`/acme-tiny.sh
    echo  '0 0 1 * * '`pwd`'/acme-tiny.sh' >./temp && crontab -u root temp && rm temp
    systemctl restart cron
    echo '已注册自动事件，请勿删除脚本'

    echo '请手动完成nginx配置后续工作'
    # 在nginx中修改配置：
    echo '      listen       443 ssl;'
    echo '      ssl_certificate      $DIR/chained.pem;'
    echo '      ssl_certificate_key  $DIR/domain.key;'
    # 其他内容请查询文档
else 
    echo "找到 $DIR/chained.pem，开始重新注册"
    mv $NGINX_CONF $NGINX_CONF.bak
    echo "events{}http{server{listen 80; server_name $YOUR_DOMAIN;location /.well-known/acme-challenge/ {
            alias $DIR/;
        }}}">$NGINX_CONF
    nginx -t && echo "nginx 临时配置完成"
    systemctl reload nginx;
    python $DIR/acme_tiny.py --account-key $DIR/account.key --csr $DIR/domain.csr --acme-dir $DIR/ > /tmp/signed.crt || exit
    wget -O - https://letsencrypt.org/certs/lets-encrypt-x3-cross-signed.pem > $DIR/intermediate.pem
    cat /tmp/signed.crt $DIR/intermediate.pem > $DIR/chained.pem
    mv $NGINX_CONF.bak $NGINX_CONF
    nginx -t && echo "nginx 配置恢复完成"
    systemctl reload nginx;
fi


echo '当前crontab事件：'
crontab -l