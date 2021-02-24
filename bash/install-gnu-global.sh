#!/usr/bin/env bash
#
# Script to install GNU Global

readonly VERSION='6.6.5'

clean_up() {
  cd && rm -rf "${tmpdir}"
}

sudo dpkg -P global 2> /dev/null
sudo apt -y install libncurses5-dev exuberant-ctags python-pip checkinstall || exit $?
sudo -H pip install pygments ${http_proxy:+--proxy ${http_proxy}} || exit $?

trap 'clean_up' EXIT

tmpdir="$(mktemp -d)"
cd "${tmpdir}"

wget http://tamacom.com/global/global-${VERSION}.tar.gz || exit $?
tar xf global-${VERSION}.tar.gz
cd global-${VERSION}

./configure || exit $?
make
sudo checkinstall --nodoc -y

cp -a /usr/local/share/gtags/gtags.conf ~/.globalrc
echo 'export GTAGSLABEL=pygments' >> ~/.profile

echo -e '\e[1;32mSucceeded to install GNU Global.\e[m'
