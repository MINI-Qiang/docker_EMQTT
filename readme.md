# 环境说明

* 系统环境为ubuntu 14.04

* 基础更新源替换成国内源（14.04）

* 更新并安装 unzip wget

* 下载emqttd-ubuntu64-1.1.2-beta-20160630版本的emqtt预编译包并安装运行

### 构建语句

docker run -t --name emqtt --link mysql:mysql -p 1883:1883 -p 8883:8883 -p 8083:8083 -p 18083:18083  miniqiang/emqtt

### 停止容器

docker stop emqtt

### 启动容器

docker start emqtt

### 开启控制台

docker exec -it emqtt /bin/bash

### 删除容器 （需先停止容器）

docker rm emqtt


### 删除镜像 （需先删除容器）

docker image rm miniqiang/emqtt


构建mysql
docker run --name mysql -p 3306:3306 -v /home/docker/mysql:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=534659123 -d mysql:latest

# 调试经验， 注意docker的mysql的配置文件，默认的user passwd都是被注释掉的。。在docker下 主机名称写链接的名称 mysql


先构建mysql  再构建emqtt
