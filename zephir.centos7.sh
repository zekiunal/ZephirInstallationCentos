#!/bin/bash

##########################################
# @package zephir
# @author Zeki Ünal <zekiunal@gmail.com>
# @name zephir.sh
##########################################

####################################################################################
# Update CentOS 7
####################################################################################
sudo yum update -y
yum install -y epel-release
rpm -Uvh https://mirror.webtatic.com/yum/el7/epel-release.rpm
rpm -Uvh https://mirror.webtatic.com/yum/el7/webtatic-release.rpm
sudo yum update -y

rpm -Uvh http://mirror.yandex.ru/fedora/russianfedora/russianfedora/free/el/releases/7/Everything/x86_64/os/re2c-0.13.5-7.el7.R.x86_64.rpm
yum install -y re2c

yum install -y httpd
chkconfig httpd on
systemctl enable httpd.service
systemctl start httpd.service

echo "Apache installed."

if ! rpm -qa | grep -qw php56w; then
    yum install -y php56w
    echo "php56w installed."
fi

if ! rpm -qa | grep -qw php56w-opcache; then
    yum install -y php56w-opcache
    echo "php56w-opcache installed."
fi

if ! rpm -qa | grep -qw php56w-common; then
    yum install -y php56w-common
    echo "php56w-common installed."
fi

if ! rpm -qa | grep -qw php56w-mysql; then
    yum install -y php56w-mysql
    echo "php56w-mysql installed."
fi

if ! rpm -qa | grep -qw php56w-pecl-memcache; then
    yum install -y php56w-pecl-memcache
    echo "php56w-pecl-memcache installed."
fi

if ! rpm -qa | grep -qw php56w-devel; then
    sudo yum install -y php56w-devel
    echo "php56w-devel installed."
fi

if ! rpm -qa | grep -qw gcc; then
    sudo yum install -y gcc
    echo "gcc installed."
fi

if ! rpm -qa | grep -qw libtool; then
    sudo yum install -y libtool
    echo "libtool installed."
fi

if ! rpm -qa | grep -qw make; then
    sudo yum install -y make
    echo "make installed."
fi

if ! rpm -qa | grep -qw git-core; then
    sudo yum install -y git-core
    echo "git installed."
fi

if ! rpm -qa | grep -qw gd; then
    sudo yum install -y gd
    echo "gd installed."
fi

if ! rpm -qa | grep -qw gd-devel; then
    sudo yum install -y gd-devel
    echo "gd-devel installed."
fi

if ! rpm -qa | grep -qw php56w-gd; then
    sudo yum install -y php56w-gd
    echo "php56w-gd installed."
fi


####################################################################################
# Install json-c
####################################################################################

git clone https://github.com/json-c/json-c.git
cd /json-c
./autogen.sh
./configure
make
make install
cd /

####################################################################################
# Install zephir
####################################################################################

git clone https://github.com/phalcon/zephir
cd zephir
./install -c
zephir help

if [ ! -f /usr/lib64/php/modules/phalcon.so ]; then

    git clone --depth=1 git://github.com/phalcon/cphalcon.git
    cd cphalcon/build
    sudo ./install

    if [ ! -L /etc/php.d/phalcon.ini ]
    then
                rm -f -r /etc/php.d/phalcon.ini
                echo "; Enable phalcon extension module" >> /etc/php.d/phalcon.ini
                echo "extension=phalcon.so" >> /etc/php.d/phalcon.ini
                echo 'date.timezone = "Europe/Istanbul"' >> /etc/php.d/phalcon.ini
    fi
    cd /
    clear
fi

service httpd restart

echo "########### Apache Installed ###########"
