#!/bin/bash

# https://phoenixnap.com/kb/how-to-install-python-3-ubuntu
# https://tech.serhatteker.com/post/2019-09/upgrade-python37-on-ubuntu18/

sudo add-apt-repository ppa:deadsnakes/ppa
sudo apt-get update -y

sudo apt-get install python3.7
sudo update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.6 1
sudo update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.7 2
sudo update-alternatives --config python3

sudo apt-get install python3-setuptools
sudo apt-get install python3-pip

sudo apt-get install python3.7-dev
sudo apt-get install libpython3.7-dev
