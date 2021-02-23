#!/usr/bin/env bash
#
# Generic Android build script

readonly -a VARIANTS=(user userdebug eng)

if [ $# -eq 0 ]; then
  echo "Usage: $(basename $0) <product> $(IFS='|'; echo "${VARIANTS[*]}") [update-api|clean]" 1>&2
  exit 1
fi

if [[ ! " ${VARIANTS[*]} " =~ " $2 " ]]; then
  echo "$2: invalid variant" 1>&2
  exit 1
fi

if [ $# -ge 3 ]; then
  if [ "$3" != 'update-api' ] && [ "$3" != 'clean' ] ; then
    echo "$3: invalid argument" 1>&2
    exit 1
  fi
fi

num_cpus=$(cat /proc/cpuinfo | grep -c processor)

source build/envsetup.sh || exit $?

lunch "$1-$2" || exit $?

LC_ALL=C make -j${num_cpus} "${3:-}" 2>&1 | tee log.txt

if [ ${PIPESTATUS[0]} -eq 0 ]; then
  echo -e '\e[1;32m'
  cat <<EOF
        @@@@@@@@@@          @@@@@@    @@@@@@@@
    @@@@          @@@@        @@        @@
    @@              @@        @@      @@
  @@                  @@      @@    @@
  @@                  @@      @@  @@
  @@                  @@      @@@@  @@
  @@                  @@      @@      @@
    @@              @@        @@        @@
    @@@@          @@@@        @@          @@
        @@@@@@@@@@          @@@@@@          @@@@
EOF
  echo -e '\e[m'
else
  echo -e '\e[1;31m'
  cat <<EOF
  @@@@          @@@@@@@@          @@@@@@@@@@  @@
    @@@@            @@        @@@@          @@@@
    @@ @@           @@        @@              @@
    @@   @@         @@      @@
    @@     @@       @@      @@
    @@       @@     @@      @@          @@@@@@@@@@
    @@         @@   @@      @@                @@
    @@           @@ @@        @@              @@
    @@            @@@@        @@@@          @@@@
  @@@@@@@@          @@            @@@@@@@@@@
EOF
  echo -e '\e[m'

  grep -A2 'error:\|FAILED' log.txt
fi
