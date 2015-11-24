echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" | tee /etc/apt/sources.list.d/webupd8team-java.list
echo "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" | tee -a /etc/apt/sources.list.d/webupd8team-java.list
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys EEA14886
apt-get update
apt-get install oracle-java9-installer subversion apt-transport-https git build-essential autoconf dh-autoreconf software-properties-common python-software-properties libcurl curl autotools-dev automake libsvn-dev libapr1 libapr1-dev libtool build-essential python-dev python-boto libcurl4-nss-dev libsasl2-dev maven libapr1-dev libsvn-dev sbt aptitude clang
git clone https://git-wip-us.apache.org/repos/asf/mesos.git
wget -q http://debian.freelan.org/debian.freelan.org.key -O- | apt-key add -
echo "deb http://debian.freelan.org/ jessie main" >> /etc/apt/sources.list
git clone https://github.com/bagder/curl
cmake curl
make -j 17
make install
wget http://mirrors.viethosting.vn/apache/subversion/subversion-1.9.2.tar.gz
tar xvf subversion-1.9.2.tar.gz
gvm use go1.5 --default
go get github.com/docker/swarm


wget get.docker.com
sh index.html
cd mesos
./bootstrap
mkdir build
cd build
../configure
make -j 9
make check -j 9
make install
echo "which IP address would you like to listen on?"
read LISTENADDR
echo "What is the IP address (with port) of the master?"
read MASTERADDR
nohup ./bin/mesos-slave.sh --master=$MASTERADDR --ip=$LISTENADDR --containerizers=docker.mesos&
