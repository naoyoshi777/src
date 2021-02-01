#!/bin/bash
#
# Script to install GNU Global

readonly VERSION='6.6.5'

sudo dpkg -r global 2> /dev/null
sudo apt -y install libncurses5-dev exuberant-ctags python-pip checkinstall
sudo -H pip install pygments "${http_proxy:+--proxy ${http_proxy}}"

wget http://tamacom.com/global/global-${VERSION}.tar.gz || exit $?
tar xf global-${VERSION}.tar.gz
cd global-${VERSION}

./configure || exit $?
make
sudo checkinstall --nodoc -y

cp -a /usr/local/share/gtags/gtags.conf ~/.globalrc
echo 'export GTAGSLABEL=pygments' >> ~/.bashrc
