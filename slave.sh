#!/bin/bash
cd ~/
echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" | tee /etc/apt/sources.list.d/webupd8team-java.list
echo "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" | tee -a /etc/apt/sources.list.d/webupd8team-java.list
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys EEA14886
apt-get update
apt-get install oracle-java9-installer apt-transport-https git build-essential autoconf python-pip libssl-dev libssl1.0.0 libssl1.0.0-dbg libaprutil1 mercurial subversion bzr openssl libaprutil1-dbg libaprutil1-dev dh-autoreconf software-properties-common python-software-properties autotools-dev automake libsvn-dev libapr1 libapr1-dev libtool build-essential libltdl-dev libltdl7 libtool libtool-bin libtool-doc libtoolkit-perl libtools-logging-clojure libtools-macro-clojure python-dev python-boto libcurl4-nss-dev libsasl2-dev maven libapr1-dev libsvn-dev aptitude clang
git clone https://git-wip-us.apache.org/repos/asf/mesos.git --depth=1
mkdir ~/mesos/build
wget get.docker.com
sh index.html
wget http://mirrors.viethosting.vn/apache/subversion/subversion-1.9.2.tar.gz
tar xvf subversion-1.9.2.tar.gz
cd subversion-1.9.2
./autogen.sh
./configure
cmake
make
make install
gvm use go1.5 --default
go get github.com/docker/swarm
cd ~/mesos/build
make clean
cd ~/mesos
./bootstrap
cd build
../configure
make -j 17
make check -j 17
make install
echo "which IP address would you like to listen on?"
read LISTENADDR
echo "What is the IP address (with port) of the master?"
read MASTERADDR
nohup ./bin/mesos-slave.sh --master=$MASTERADDR --ip=$LISTENADDR --containerizers=docker,mesos&
