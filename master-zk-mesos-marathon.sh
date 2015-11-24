cd ~/
echo "deb https://dl.bintray.com/sbt/debian /" | sudo tee -a /etc/apt/sources.list.d/sbt.list
echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" | tee /etc/apt/sources.list.d/webupd8team-java.list
echo "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" | tee -a /etc/apt/sources.list.d/webupd8team-java.list
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys EEA14886
apt-get update
apt-get install oracle-java9-installer apt-transport-https git build-essential autoconf dh-autoreconf libcurl curl autotools-dev automake libtool build-essential python-dev python-boto libcurl4-nss-dev libsasl2-dev maven libapr1-dev libsvn-dev sbt aptitude clang
git clone https://git-wip-us.apache.org/repos/asf/mesos.git
wget -q http://debian.freelan.org/debian.freelan.org.key -O- | apt-key add -
echo "deb http://debian.freelan.org/ jessie main" >> /etc/apt/sources.list
cd mesos
./bootstrap
mkdir build
cd build
../configure
make -j 9
make check -j 9
make install

cd ~/
git clone https://github.com/mesosphere/marathon.git
cd marathon
sbt assembly
echo "For your reference, here are the default start commands for master's services."
echo "mesos: cd ~/mesos/build"
echo "mesos: nohup sh mesos-master.sh --ip=10.182.3.4  --work_dir=/var/lib/mesos &"
echo "zookeeper: service zookeeper start"
echo "marathon: cd ~/marathon"
echo "marathon: nohup ./bin/start --master 10.182.3.4:5050 --zk zk://localhost:2181/marathon &"



