#!/bin/bash

####################################################################################
# @package zephir installer
# @author Zeki Unal <zekiunal@gmail.com>
# @name zephir.sh
####################################################################################

####################################################################################
# Update CentOS
####################################################################################
sudo yum update -y
rpm -Uvh http://mirror.webtatic.com/yum/el6/latest.rpm

####################################################################################
# Install WGet
####################################################################################
sudo yum install -y wget


yum update -y
rpm -Uvh http://mirror.webtatic.com/yum/el6/latest.rpm
yum install -y httpd
chkconfig httpd on
service httpd start
yum install -y php55w
sudo yum install -y php55w-devel
sudo yum install -y gcc
sudo yum install -y make
sudo yum install -y git-core
yum install -y wget
wget http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
wget http://rpms.famillecollet.com/enterprise/remi-release-6.rpm
rpm -Uvh remi-release-6*.rpm epel-release-6*.rpm
sudo yum install -y re2c
yum install -y php55w-json
git clone https://github.com/json-c/json-c.git
sudo yum install -y libtool
cd /json-c
./autogen.sh
./configure
make
make install
git clone https://github.com/phalcon/zephir
cd zephir
./install -c
zephir help
