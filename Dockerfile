#系统环境定义
FROM ubuntu:14.04

#维护者信息
MAINTAINER MiniQiang <chenglei1234@gmail.com>

#换国内源
RUN rm /etc/apt/sources.list \
	&& echo "deb http://cn.archive.ubuntu.com/ubuntu/ trusty main restricted universe multiverse" >> /etc/apt/sources.list\
	&& echo "deb http://cn.archive.ubuntu.com/ubuntu/ trusty-security main restricted universe multiverse" >> /etc/apt/sources.list\
	&& echo "deb http://cn.archive.ubuntu.com/ubuntu/ trusty-updates main restricted universe multiverse" >> /etc/apt/sources.list\
	&& echo "deb http://cn.archive.ubuntu.com/ubuntu/ trusty-backports main restricted universe multiverse" >> /etc/apt/sources.list\
	&& echo "deb http://cn.archive.ubuntu.com/ubuntu/ trusty-proposed main restricted universe multiverse" >> /etc/apt/sources.list\
	&& echo "deb-src http://cn.archive.ubuntu.com/ubuntu/ trusty main restricted universe multiverse" >> /etc/apt/sources.list\
	&& echo "deb-src http://cn.archive.ubuntu.com/ubuntu/ trusty-security main restricted universe multiverse" >> /etc/apt/sources.list\
	&& echo "deb-src http://cn.archive.ubuntu.com/ubuntu/ trusty-updates main restricted universe multiverse" >> /etc/apt/sources.list\
	&& echo "deb-src http://cn.archive.ubuntu.com/ubuntu/ trusty-backports main restricted universe multiverse" >> /etc/apt/sources.list\
	&& echo "deb-src http://cn.archive.ubuntu.com/ubuntu/ trusty-proposed main restricted universe multiverse" >> /etc/apt/sources.list
#更新源	
RUN apt-get update
############################################

#系统变量，安装的服务器版本信息
ENV EMQTTD_VERSION=emqttd-ubuntu64-1.1.2-beta-20160630

#添加启动脚本,配置文件
COPY start.sh /home/start.sh

COPY conf/ /home/conf/


#部署环境工具
RUN apt-get install -y unzip \
	&& apt-get install -y wget
	
RUN cd /home \
	&& wget http://emqtt.com/static/brokers/${EMQTTD_VERSION}.zip \
	&& unzip ${EMQTTD_VERSION}.zip \
	&& rm -rf /var/lib/apt/lists/*

RUN cd /home/emqttd/ \
	&& cp /home/start.sh /home/emqttd/start.sh \
	&& chmod 755 /home/emqttd/start.sh \
	&& cp -Rf /home/conf/* /home/emqttd/ \ 
#清理残留文件
	&& rm -rf /home/conf/ \     
	&& rm -rf /home/start.sh
	


#容器启动命令
CMD ["/home/emqttd/start.sh"]

#工作目录设置
WORKDIR /home/emqttd

#定义映射目录
#VOLUME ["/home/emqttd/etc/", "/home/emqttd/data/", "/home/emqttd/plugins/"]

# emqttd will occupy 1883 port for MQTT, 8883 port for MQTT(SSL), 8083 for WebSocket/HTTP, 18083 for dashboard
EXPOSE 1883 8883 8083 18083