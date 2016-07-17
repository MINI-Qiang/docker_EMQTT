# 环境说明

* 系统环境为ubuntu 14.04

* 基础更新源替换成国内源（14.04）

* 更新并安装 unzip wget

* 下载emqttd-ubuntu64-1.1.2-beta-20160630版本的emqtt预编译包并安装运行

### 构建语句

docker run -t  --name emqtt -p 1883:1883 8883:8883 8083:8083 18083:18083  miniqiang/emqtt

