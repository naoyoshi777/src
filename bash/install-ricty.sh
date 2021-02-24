#!/usr/bin/env bash
#
# Script to install Ricty font

clean_up() {
  cd && rm -rf "${tmpdir}"
}

if ! type fontforge &> /dev/null; then
  sudo apt -y install fontforge || exit $?
fi

trap 'clean_up' EXIT

tmpdir="$(mktemp -d)"
cd "${tmpdir}"

wget https://rictyfonts.github.io/files/ricty_generator.sh || exit $?
chmod +x ricty_generator.sh

wget https://osdn.net/projects/mix-mplus-ipa/downloads/72511/migu-1m-20200307.zip || exit $?
unzip migu-1m-20200307.zip
mv migu-1m-20200307/migu-1m-* .

git clone https://github.com/googlefonts/Inconsolata.git || exit $?

./ricty_generator.sh auto

mkdir -p ~/.local/share/fonts/
mv Ricty-*.ttf ~/.local/share/fonts/
fc-cache -fv

echo -e '\e[1;32mSucceeded to install Ricty font.\e[m'
