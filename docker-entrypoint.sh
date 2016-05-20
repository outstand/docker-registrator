#!/bin/sh
set -e

if [ "${1:0:1}" = '-' ]; then
    set -- registrator "$@"
fi

if expr "$1" : '[A-Za-z0-9_-]*://' >/dev/null; then
    set -- registrator "$@"
fi

if [ "$1" = 'registrator' ]; then
  if [ -n "$TAG_AWS_AZ" ]; then
    AZ=$(wget -O - -q http://169.254.169.254/latest/meta-data/placement/availability-zone)
    shift
    set -- registrator -tags "$AZ" "$@"
  fi
fi

exec "$@"
