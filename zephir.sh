#!/bin/bash

####################################################################################
# @package zephir installer
# @author Zeki Unal <zekiunal@gmail.com>
# @name zephir.sh
####################################################################################

####################################################################################
# Update CentOS
####################################################################################
rpm -Uvh http://mirror.webtatic.com/yum/el6/latest.rpm
wget http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
wget http://rpms.famillecollet.com/enterprise/remi-release-6.rpm
rpm -Uvh remi-release-6*.rpm epel-release-6*.rpm
sudo yum update -y

####################################################################################
# Install wget
####################################################################################

if ! rpm -qa | grep -qw wget; then
    # install wget
    sudo yum install -y wget 
    echo "wget installed."
fi


####################################################################################
# Install libtool
####################################################################################
if ! rpm -qa | grep -qw libtool; then
    sudo yum install -y libtool
    echo "libtool installed."
fi

####################################################################################
# Install gcc
####################################################################################

if ! rpm -qa | grep -qw gcc; then
    sudo yum install -y gcc 
    echo "gcc installed."
fi

####################################################################################
# Install make
####################################################################################

if ! rpm -qa | grep -qw make; then
    sudo yum install -y make 
    echo "make installed."
fi

####################################################################################
# Install re2c
####################################################################################
if ! rpm -qa | grep -qw re2c; then
    sudo yum install -y re2c
    echo "re2c installed."
fi

####################################################################################
# Install Apache
####################################################################################

if ! rpm -qa | grep -qw httpd; then

    #install httpd
    sudo yum install -y httpd 
    
    chkconfig httpd on
    
    #edit httpd.conf
    grep -l '#ServerName www.example.com:80' /etc/httpd/conf/httpd.conf | xargs sed -e 's/#ServerName www.example.com:80/ServerName localhost/' -i
    grep -l 'AllowOverride None' /etc/httpd/conf/httpd.conf | xargs sed -e 's/AllowOverride None/AllowOverride All/g' -i
    
    #remove empty lines
    sed -i '/^$/d' /etc/httpd/conf/httpd.conf
    
    #turn on httpd
    service httpd start
    
    echo "httpd installed."
fi

####################################################################################
# Install php55w
####################################################################################

if ! rpm -qa | grep -qw php55w; then
    sudo yum install -y php55w 
    echo "php55w installed."
fi

####################################################################################
# Install php55w-devel
####################################################################################

if ! rpm -qa | grep -qw php55w-devel; then
    sudo yum install -y php55w-devel 
    echo "php55w-devel installed."
fi

####################################################################################
# Install php55w-json
####################################################################################

if ! rpm -qa | grep -qw php55w-json; then
    sudo yum install -y php55w-json
    echo "php55w-json installed."
fi

################################################################################
# Restart httpd
################################################################################
service httpd restart

################################################################################
# Install git-core
################################################################################

if ! rpm -qa | grep -qw git-core; then
    sudo yum install -y git-core 
    echo "git installed."
fi

####################################################################################
# Install json-c
####################################################################################

git clone https://github.com/json-c/json-c.git
sudo yum install -y libtool
cd /json-c
./autogen.sh
./configure
make
make install

####################################################################################
# Install zephir
####################################################################################

git clone https://github.com/phalcon/zephir
cd zephir
./install -c
zephir help
