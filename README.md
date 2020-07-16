## QRCode
二维码生成工具，Java
# 编译环境
### jdk1.8以上
### maven3
# 编译说明
#### 1、执行maven编译打包命令(或者直接下载编译好的[jar](https://github.com/Soroke/QRCode/releases)包)
```shell script
mvn clean install
```
#### 2、编译完成后target目录下获取jar包
# 使用说明
#### 1、仅指定url路径，默认生成二维码到当前目录下
```shell script
java -jar XXX.jar "http://www.baidu.com"
```
#### 2、指定url路径和二维码文件存放路径
```shell script
java -jar XXX.jar "http://www.baidu.com" "/usr/local/"
```
#### 3、指定url路径和二维码文件存放路径 二维码文件名称
```shell script
java -jar XXX.jar "http://www.baidu.com" "/usr/local/" "xxx.png"
```

#### 4、指定url路径、二维码文件存放路径 二维码文件名称 二维码宽度 二维码的高度
####  宽度和高度的单位为px 像素
```shell script
java -jar XXX.jar "http://www.baidu.com" "/usr/local/" "xxx.png" "500" "500"
```
# 版本支持信息