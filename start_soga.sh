#!/bin/bash

#判断系统信息
Get_Dist_Name(){
    if grep -Eqii "CentOS" /etc/issue || grep -Eq "CentOS" /etc/*-release; then
        DISTRO='CentOS'
        PM='yum'
    elif grep -Eqi "Red Hat Enterprise Linux Server" /etc/issue || grep -Eq "Red Hat Enterprise Linux Server" /etc/*-release; then
        DISTRO='RHEL'
        PM='yum'
    elif grep -Eqi "Aliyun" /etc/issue || grep -Eq "Aliyun" /etc/*-release; then
        DISTRO='Aliyun'
        PM='yum'
    elif grep -Eqi "Fedora" /etc/issue || grep -Eq "Fedora" /etc/*-release; then
        DISTRO='Fedora'
        PM='yum'
    elif grep -Eqi "Debian" /etc/issue || grep -Eq "Debian" /etc/*-release; then
        DISTRO='Debian'
        PM='apt'
    elif grep -Eqi "Ubuntu" /etc/issue || grep -Eq "Ubuntu" /etc/*-release; then
        DISTRO='Ubuntu'
        PM='apt'
    elif grep -Eqi "Raspbian" /etc/issue || grep -Eq "Raspbian" /etc/*-release; then
        DISTRO='Raspbian'
        PM='apt'
    else
        DISTRO='unknow'
    fi
    echo $DISTRO;
}
Get_Dist_Name


#不同系统安装
function ubuntu_docker() {
	sudo apt-get update
	sudo apt-get install apt-transport-https ca-certificates curl gnupg lsb-release -y
	curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
	echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null	
	sudo apt-get update
	sudo apt-get install docker-ce docker-ce-cli containerd.io
	systemctl start docker
	systemctl enable docker
}

function deb_docker() {
	sudo apt-get update
	sudo apt-get install apt-transport-https ca-certificates curl gnupg lsb-release -y
	curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
	echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
	sudo apt-get update
	sudo apt-get install docker-ce docker-ce-cli containerd.io
	systemctl start docker
	systemctl enable docker
}

function centos_docker() {
	sudo yum install -y yum-utils
	sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
	yum-config-manager --enable docker-ce-nightly
	sudo yum-config-manager --enable docker-ce-test
	sudo yum-config-manager --disable docker-ce-nightly
	sudo yum install docker-ce docker-ce-cli containerd.io
	systemctl start docker
	systemctl enable docker
}

function fedora_docker() {
	sudo dnf -y install dnf-plugins-core
	sudo dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo
	sudo dnf config-manager --set-enabled docker-ce-nightly
	sudo dnf config-manager --set-enabled docker-ce-test
	sudo dnf config-manager --set-disabled docker-ce-nightly
	sudo dnf install docker-ce docker-ce-cli containerd.io
	systemctl start docker
	systemctl enable docker
}

#安装docker
if [ $DISTRO == "CentOS" ];then
	centos_docker
elif [ $DISTRO == "Fedora" ];then
	fedora_docker
elif [ $DISTRO == "Debian" ];then
	deb_docker
elif [ $DISTRO == "Ubuntu" ];then
	ubuntu_docker
else
	echo "无法识别的系统。"
	exit -1
fi

#安装docker-compose
sudo curl -L https://github.com/docker/compose/releases/download/1.29.1/docker-compose-`uname -s`-`uname -m` -o /usr/bin/docker-compose
sudo chmod +x /usr/bin/docker-compose

#生成配置文件
ymlFile="version: \"3\"\nservices:\n\tsoga:\n\t\timage: sprov065/soga:latest\n\t\trestart: on-failure\n\t\tnetwork_mode: host\n\t\tenvironment:\n\t\t\ttype: sspanel-uim\n\t\t\tserver_type: v2ray\n\t\t\tapi: webapi\n\t\t\twebapi_url: https://xxx.com/\n\t\t\twebapi_key: xxxxxx\n\t\t\tnode_id: 0\n\t\t\tcert_domain: aaa.com\n\t\t\tcert_mode: http\n\t\t\tforce_close_ssl: 'false'\n\t\t\tforbidden_bit_torrent: 'true'\n\t\tvolumes:\n\t\t\t- \"/etc/soga/:/etc/soga/\""

if [ $# -eq 4 ];then
	ymlFile="version: \"3\"\nservices:\n\tsoga:\n\t\timage: sprov065/soga:latest\n\t\trestart: on-failure\n\t\tnetwork_mode: host\n\t\tenvironment:\n\t\t\ttype: sspanel-uim\n\t\t\tserver_type: $1\n\t\t\tapi: webapi\n\t\t\twebapi_url: $2\n\t\t\twebapi_key: $3\n\t\t\tnode_id: $4\n\t\t\tcert_domain: aaa.com\n\t\t\tcert_mode: http\n\t\t\tforce_close_ssl: 'false'\n\t\t\tforbidden_bit_torrent: 'true'\n\t\tvolumes:\n\t\t\t- \"/etc/soga/:/etc/soga/\""
	if [ ! -d "ssr" ];then
		mkdir ssr
	fi
	/bin/echo -e $ymlFile > ssr/docker-composer.yml
	cd ssr && docker-compose up -d
elif [ $# -eq 5 ];then
	ymlFile="version: \"3\"\nservices:\n\tsoga:\n\t\timage: sprov065/soga:latest\n\t\trestart: on-failure\n\t\tnetwork_mode: host\n\t\tenvironment:\n\t\t\ttype: sspanel-uim\n\t\t\tserver_type: $1\n\t\t\tapi: webapi\n\t\t\twebapi_url: $2\n\t\t\twebapi_key: $3\n\t\t\tnode_id: $4\n\t\t\tcert_domain: $5\n\t\t\tcert_mode: http\n\t\t\tforce_close_ssl: 'false'\n\t\t\tforbidden_bit_torrent: 'true'\n\t\tvolumes:\n\t\t\t- \"/etc/soga/:/etc/soga/\""
	if [ ! -d "trojan" ];then
		mkdir trojan
	fi
	/bin/echo -e $ymlFile > trojan/docker-composer.yml
	cd trojan && docker-compose up -d
else
	/bin/echo -e $ymlFile > docker-composer.yml
	/bin/echo -e "参数数量不正确,请手动修改配置:./docker-composer.yml\n\tssr格式：ssr https://xxx.com/ key node_id\n\ttrojan格式：trojan https://xxx.com/ key node_id cert_domain"
	exit -1
fi
	