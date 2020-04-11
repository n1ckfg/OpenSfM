#!/bin/bash

# https://opensource.com/article/19/5/python-3-default-mac

PYTHON_VERSION=3.7.7

brew install pyenv
pyenv install $PYTHON_VERSION
pyenv global $PYTHON_VERSION
python --version