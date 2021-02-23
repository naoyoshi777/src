#!/usr/bin/env bash
#
# Generic build script

readonly LOGFILE='buildlog.txt'

SECONDS=0

LANG=C make "$@" 2>&1 | tee "${LOGFILE}"

ret=${PIPESTATUS[0]}

duration=${SECONDS}

if [ ${ret} -eq 0 ]; then
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

  grep -A2 'error:\|FAILED' "${LOGFILE}"
fi

hr=

if (( duration >= 3600 )); then
  hr=$(( duration / 3600 ))
  duration=$(( duration % 3600 ))
fi

min=

if (( duration >= 60 )); then
  min=$(( duration / 60 ))
  duration=$(( duration % 60 ))
elif [ "${hr}" ]; then
  min=0
fi

sec=${duration}

echo "Time: ${hr:+${hr}h }${min:+${min}m }${sec}s"
