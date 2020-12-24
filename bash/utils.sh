#!/bin/bash
#
# Utility functions by BASH builtin commands

################################################################################
# Print message in bold and red to stderr and exit script.
#
# Arguments:
#   $1  message
################################################################################
utils::abort() {
  echo -e "\e[1;31m$1\e[m" >&2
  exit 1
}

################################################################################
# Get value of the given attribute name.
#
# Arguments:
#   $1  attribute name
#   $2  string (OPTIONAL: If not specified, standard input is read)
# Stdout:
#   attribute value
################################################################################
utils::get_attr_value() {
  local str="${2:-}"
  local pattern=" $1=\"([^\"]*)\""

  if [ -p '/dev/stdin' ]; then
    str=$(cat -)
  fi

  if [[ "${str}" =~ ${pattern} ]]; then
    echo "${BASH_REMATCH[1]}"
  fi
}

################################################################################
# Check if the given value is contained in array.
#
# Arguments:
#   $1  value
#   $2  array
# Return:
#   0 if the value is contained in array.
################################################################################
utils::in_array() {
  local i=

  for i in "${@:2}"; do
    if [ "${i}" = "$1" ]; then
      return 0
    fi
  done

  return 1
}

################################################################################
# Check if the given value is integer
#
# Arguments:
#   $1  value
# Return:
#   0 if the value is integer.
################################################################################
utils::is_integer() {
  [ "$1" -eq "$1" ] 2> /dev/null
}

################################################################################
# Check if the given value is positive integer
#
# Arguments:
#   $1  value
# Return:
#   0 if the value is positive integer.
################################################################################
utils::is_positive_integer() {
  utils::is_integer "$1" && [ $1 -gt 0 ]
}

################################################################################
# Check if the given address is valid IPv4 address.
#
# Arguments:
#   $1  IP address
# Return:
#   0 if the address is valid IPv4 address.
################################################################################
utils::is_ipv4_address() {
  local -i ret=1
  local ip="${1%:*}" # remove port part (e.g., :5555)

  if [[ ${ip} =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]]; then
    local IFS='.'; set -- ${ip}
    [[ $1 -le 255 && $2 -le 255 && $3 -le 255 && $4 -le 255 ]]
    ret=$?
  fi

  return ${ret}
}

################################################################################
# Concatenate all the elements using the given separator.
#
# Arguments:
#   $1     separator
#   $2...  elements
# Stdout:
#   concatenated string
################################################################################
utils::join() {
  if [ $# -ge 2 ]; then
    local i=
    local str="$2"

    for i in "${@:3}"; do
      str+="$1${i}"
    done

    echo "${str}"
  fi
}

################################################################################
# Parse a Unix style configuration file.
#
# Arguments:
#   $1  path to file
################################################################################
utils::parse_conf_file() {
  local key=
  local val=

  while IFS='=' read key val; do
    if [ ! "${key}" ] || [ "${key:0:1}" = '#' ]; then
      continue
    fi

    echo "key=${key}  val=${val}"
  done < "$1"
}

################################################################################
# Print "OK" largely.
#
# Arguments:
#   None
################################################################################
utils::print_ok() {
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
}

################################################################################
# Print "NG" largely.
#
# Arguments:
#   None
################################################################################
utils::print_ng() {
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
}

################################################################################
# Wait until the user inputs 'y' or 'n'.
#
# Arguments:
#   $1  default answer ('y' or 'n')
#   $2  prompt
################################################################################
utils::wait_for_input_y_or_n() {
  local prompt=
  local -i ret=

  if [ "${1,,}" = 'y' ]; then
    prompt=$(echo -e "\e[1;33m$2 [Y/n]? \e[m")
    ret=0
  else
    prompt=$(echo -e "\e[1;33m$2 [y/N]? \e[m")
    ret=1
  fi

  while :; do
    read -p "${prompt}"

    if [ ! "${REPLY}" ]; then
      return ${ret}
    elif [ "${REPLY,,}" = 'y' ]; then
      return 0
    elif [ "${REPLY,,}" = 'n' ]; then
      return 1
    else
      echo 'Please answer y or n.'
    fi
  done
}
