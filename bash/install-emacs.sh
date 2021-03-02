#!/usr/bin/env bash
#
# Script to install Emacs from source

readonly EMACS_VERSION='27.1'

clean_up() {
  cd && rm -rf "${tmpdir}"
}

sudo apt -y install checkinstall autoconf libgtk-3-dev libjpeg-dev libxpm-dev libgif-dev libtiff-dev libgnutls28-dev || exit $?

trap 'clean_up' EXIT

tmpdir="$(mktemp -d)"
cd "${tmpdir}"

wget -O - http://ftp.jaist.ac.jp/pub/GNU/emacs/emacs-"${EMACS_VERSION}".tar.xz | tar xJf - || exit $?
cd emacs-"${EMACS_VERSION}"

./autogen.sh || exit $?
./configure --disable-largefile --without-sound || exit $?
make
sudo checkinstall --nodoc -y

echo -e '\e[1;32mSucceeded to install Emacs.\e[m'
