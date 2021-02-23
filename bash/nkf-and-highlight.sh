#!/usr/bin/env bash
#
# Convert input file to UTF-8, then convert to syntax highlighted document
#
# Append the following lines to ~/.bashrc.
#
#   if type nkf-and-highlight.sh &> /dev/null; then
#     LESSOPEN="| $_ %s"
#   fi

readonly HILITE_LESSPIPE='/usr/share/source-highlight/src-hilite-lesspipe.sh'

if ! type nkf &> /dev/null; then
  exit 1
fi

if [ ! -x "${HILITE_LESSPIPE}" ]; then
  exit 1
fi

if [ $# -eq 0 ] || [ ! -f "$1" ]; then
  exit 1
fi

code="$(nkf -g "$1")"
if [ $? -ne 0 ]; then
  exit
fi

if [ "${code}" = 'ASCII' ] || \
     [ "${code}" = 'BINARY' ] || \
     [ "${code:0:3}" = 'UTF' ]; then
  "${HILITE_LESSPIPE}" "$1"
else
  tmpfile="$(mktemp --suffix ".$(basename "$1")")"
  nkf -w "$1" > "${tmpfile}"
  "${HILITE_LESSPIPE}" "${tmpfile}"
  rm "${tmpfile}"
fi
