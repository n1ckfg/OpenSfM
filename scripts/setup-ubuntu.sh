#!/bin/bash

# https://www.opensfm.org/docs/building.html

cd ..

SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"

git submodule update --init --recursive

# Install apt-getable dependencies
sudo apt-get update    
sudo apt-get install -y build-essential cmake git libatlas-base-dev libeigen3-dev libgoogle-glog-dev libopencv-dev libsuitesparse-dev python-dev python-numpy python-opencv python-pip python-pyproj python-scipy python-yaml curl vim    
sudo apt-get clean    
sudo rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# ceres
sudo mkdir -p /source
cd /source
sudo wget http://ceres-solver.org/ceres-solver-1.14.0.tar.gz
sudo tar -xvf ceres-solver-1.14.0.tar.gz
cd /source/ceres-solver-1.14.0
sudo mkdir -p build
cd build
sudo cmake .. -DCMAKE_C_FLAGS=-fPIC -DCMAKE_CXX_FLAGS=-fPIC -DBUILD_EXAMPLES=OFF -DBUILD_TESTING=OFF
sudo make -j4 install
cd /
sudo rm -rf /source/ceres-solver-1.14.0

# opengv
sudo mkdir -p /source
cd /source
sudo git clone https://github.com/paulinus/opengv.git
cd /source/opengv
sudo git submodule update --init --recursive
sudo mkdir -p build
cd build
sudo cmake .. -DBUILD_TESTS=OFF -DBUILD_PYTHON=ON -DPYBIND11_PYTHON_VERSION=3.7 -DPYTHON_INSTALL_DIR=/usr/local/lib/python3.7/dist-packages/     
sudo make install
cd /
sudo rm -rf /source/opengv

# Install python requirements
sudo pip3 install exifread==2.1.2 gpxpy==1.1.2 networkx==1.11 numpy pyproj==1.9.5.1 pytest==3.0.7 python-dateutil==2.6.0 PyYAML==3.12 scipy xmltodict==0.10.2 loky repoze.lru
sudo pip3 install opencv-python pyproj Pillow joblib xmltodict scipy repoze.lru

cd $DIR

sudo python3 setup.py build

