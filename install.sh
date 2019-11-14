#!/bin/sh

# change sources to mirror in China
mv /etc/apt/sources.list /etc/apt/sources.list.save
mv sources.list /etc/apt/sources.list

apt-get update

# set timezone
apt-get install -y apt-utils tzdata
echo Asia/Shanghai > /etc/timezone && dpkg-reconfigure --frontend noninteractive tzdata

# install jdk8
apt-get install -y openjdk-8-jdk

# install python and pip
apt-get install -y python python3 python-pip

# install dependencies for cppcheck
apt-get install -y wget make libpcre3-dev python3-lxml
pip install protobuf
# fetch cppcheck, compile and install
wget "https://github.com/danmar/cppcheck/archive/1.89.tar.gz"
tar xf 1.89.tar.gz && rm 1.89.tar.gz
cd cppcheck-1.89
make MATCHCOMPILER=yes FILESDIR=/usr/share/cppcheck HAVE_RULES=yes CXXFLAGS="-O2 -DNDEBUG -Wall -Wno-sign-compare -Wno-unused-function" -j $(nproc) install
cd .. && rm -rf cppcheck-1.89

# install cpplint
pip install cpplint

# install git for fetching code
apt-get install -y git

# install bsdmainutils for hexdump(some projects depend on this to build)
apt-get install -y bsdmainutils

# install sudo(some projects depend on this to build)
apt-get install -y sudo

# install curl for fetching bazel
apt-get install -y curl
# install prerequisites of bazel
apt-get install -y pkg-config zip g++ zlib1g-dev unzip

echo "deb [arch=amd64] http://storage.googleapis.com/bazel-apt stable jdk1.8" | tee /etc/apt/sources.list.d/bazel.list
curl https://bazel.build/bazel-release.pub.gpg | apt-key add -

apt-get update
apt-get install -y bazel
rm -rf /var/lib/apt/lists/*

# write default bazel config
echo "build --spawn_strategy=standalone --genrule_strategy=standalone"\
> /root/.bazelrc

# run bazel to avoid "Extracting Bazel installation..."
bazel
