#!/bin/bash
cd ~/
echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" | tee /etc/apt/sources.list.d/webupd8team-java.list
echo "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" | tee -a /etc/apt/sources.list.d/webupd8team-java.list
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys EEA14886
apt-get update
apt-get install oracle-java9-installer apt-transport-https git build-essential autoconf dh-autoreconf software-properties-common python-software-properties autotools-dev automake libsvn-dev libapr1 libapr1-dev libtool build-essential python-dev python-boto libcurl4-nss-dev libsasl2-dev maven libapr1-dev libsvn-dev aptitude clang
git clone https://git-wip-us.apache.org/repos/asf/mesos.git --depth=1
wget -q http://debian.freelan.org/debian.freelan.org.key -O- | apt-key add -
echo "deb http://debian.freelan.org/ jessie main" >> /etc/apt/sources.list
wget get.docker.com
sh index.html
wget http://mirrors.viethosting.vn/apache/subversion/subversion-1.9.2.tar.gz
tar xvf subversion-1.9.2.tar.gz
cd subversion-1.9.2
./autogen.sh
./configure
make
make install
cd ~/
wget http://mirrors.viethosting.vn/apache//apr/apr-1.5.2.tar.gz
wget http://mirrors.viethosting.vn/apache//apr/apr-util-1.5.4.tar.gz
wget http://mirrors.viethosting.vn/apache//apr/apr-iconv-1.2.1.tar.gz
tar xvf apr-1.5.2.tar.gz
cd apr-1.5.2
./configure
make
make install
tar xvf apr-util-1.5.4.tar.gz
./configure
make
make install
tar xvf apr-iconv-1.2.1.tar.gz
./configure
make
make install
cd mesos
./bootstrap
mkdir build
cd build
../configure
make -j 17
make check -j 17
make install
echo "which IP address would you like to listen on?"
read LISTENADDR
echo "What is the IP address (with port) of the master?"
read MASTERADDR
nohup ./bin/mesos-slave.sh --master=$MASTERADDR --ip=$LISTENADDR --containerizers=docker.mesos&
