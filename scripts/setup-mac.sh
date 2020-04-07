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

brew install opencv
brew install ceres-solver
brew install eigen
#sudo pip3 install -r requirements.txt
sudo pip3 install exifread==2.1.2 gpxpy==1.1.2 networkx==1.11 numpy pyproj==1.9.5.1 pytest==3.0.7 python-dateutil==2.6.0 PyYAML==3.12 scipy xmltodict==0.10.2 loky repoze.lru
sudo pip3 install opencv-python pyproj Pillow joblib xmltodict scipy repoze.lru wheel six

cd ../..
git clone --recurse-submodules -j8 https://github.com/paulinus/opengv.git
cd opengv
mkdir build
cd build
cmake .. -DBUILD_TESTS=OFF -DBUILD_PYTHON=ON
sudo make install

cd $DIR

python3 setup.py build

