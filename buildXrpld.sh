#!/usr/bin/env bash
set -x

set -e

cd ~

# Install dependencies

sudo apt-get update

sudo apt-get -y upgrade

sudo apt-get -y install git pkg-config protobuf-compiler libprotobuf-dev libssl-dev wget build-essential cmake

wget https://dl.bintray.com/boostorg/release/1.71.0/source/boost_1_71_0.tar.gz

tar xvzf boost_1_71_0.tar.gz

cd boost_1_71_0

./bootstrap.sh

./b2 -j 4

export BOOST_ROOT=/home/$USER/boost_1_71_0

source ~/.profile

# Build rippled

cd ~

git clone https://github.com/ripple/rippled.git

cd rippled

git checkout master

mkdir build

cd build

cmake .. -DCMAKE_BUILD_TYPE=Release

cmake --build .

./rippled -u >> tests.log

# Configure rippled

mkdir -p ~/.config/ripple

cd ~/rippled

cp cfg/rippled-example.cfg ~/.config/ripple/rippled.cfg

cp cfg/validators-example.txt ~/.config/ripple/validators.txt

# Set rippled service

sudo printf "[Unit]
Description=Ripple Daemon
After=network-online.target
Wants=network-online.target

[Service]
Type=simple
ExecStart=/home/$USER/rippled/build/rippled --net --silent --conf /home/$USER/.config/ripple/rippled.cfg
Restart=on-failure
User=$USER
Group=$USER
LimitNOFILE=65536

[Install]
WantedBy=multi-user.target" >> /etc/systemd/system/rippled.service