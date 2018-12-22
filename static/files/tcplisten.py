#!/usr/bin/python3
# -*- coding: utf-8 -*-
import os,threading,time
from collections import Counter

rec="/tmp/record.log"
os.system("touch "+rec)
# 指定记录地址

# 定义记录方法
def record(str):
    os.system("echo '"+str+"' >> "+rec)
    print(str)

netdev=os.popen("cat /proc/net/dev|grep en|awk -F ':' '{print $1}'").read().split('\n')[0]
# 指定网卡，可以使用/proc/net/dev与ifconfig查看

src_ban=" src "+os.popen("ifconfig "+netdev+" |grep inet|grep -v inet6|awk '{print $2}'").read().split('\n')[0]
# 获取该网卡使用的地址，在tcpdump中只检查该源地址发出的包

def tcpdumppy(*dst_ban):
    cmd="sudo tcpdump -i "+netdev+" -t -nn ' "+src_ban      
    for i in dst_ban:
        cmd+=" and ! dst "+i        
        # 排除掉需要ban的目标地址
    cmd+="'|awk '{print $4}' 1> /tmp/test.log"
    # 生成tcp执行命令
    print(cmd)
    os.system(cmd)

# 函数载入一个counter，截断并分析从tcpdump抓取的流量目的地址
# 进行统计并间隔输出
def count(sec):
    second=int(sec)
    while 1:
        print("start to sleep")
        time.sleep(second)
        print("sleep for "+sec+"s")
        os.system("mv /tmp/test.log /tmp/test.log.tmp")     # 记录截断
        dt=os.popen("date").read()
        c=Counter()                                         # 创建计数器
        with open("/tmp/test.log.tmp") as f:
            while 1:
                line = f.readline()
                if not line:
                    break
                ip=".".join(line.split('.')[0:-1])          
                # 将末尾的服务协议去除，再还原之前的地址
                c[ip]= c[ip] + 1              
                # 以ip地址为key累加
            record("=== fetch info in "+sec+"s ===")
            for i in c:
                location=os.popen("geoiplookup "+i).read() # 使用geoiplookup寻找ip来源
                slocation=" ".join(location.split(' ')[3:]) # 切除掉地理地址的无用部分
                record(" : ".join([str(c[i]),slocation]))            # 人性化展示
            record("=== end of "+dt.split('\n')[0]+" ===")



tcpdumppy = threading.Thread(target=tcpdumppy, name='tcpdumppy',args=("183.236.0.89","183.40.214.231"))
# ban掉流量转发的终点
count= threading.Thread(target=count, name='count',args=("20",))
# 设置统计的时间间隔为20s
tcpdumppy.start()
count.start()
tcpdumppy.join()
count.join()
# 开始线程

