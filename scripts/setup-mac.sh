#!/bin/bash

# https://www.opensfm.org/docs/building.html

SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"

cd $DIR

brew install opencv
brew install ceres-solver
brew install eigen
sudo pip install -r requirements.txt

cd ../..
git clone --recurse-submodules -j8 https://github.com/paulinus/opengv.git
cd opengv
mkdir build
cd build
cmake .. -DBUILD_TESTS=OFF -DBUILD_PYTHON=ON
sudo make install

cd $DIR

python setup.py build

