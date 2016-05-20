#!/bin/bash
set -e

if [ "${1:0:1}" = '-' ]; then
    set -- registrator "$@"
fi

if expr "$1" : '[A-Za-z0-9_-]*://' >/dev/null; then
    set -- registrator "$@"
fi

function join { local IFS="$1"; shift; echo "$*"; }

if [ "$1" = 'registrator' ]; then
  if [ -n "$TAG_AWS" ]; then
    echo "==> Looking for AWS metadata"
    declare -a TAGS

    set +e

    AZ=$(wget -O - -q http://169.254.169.254/latest/meta-data/placement/availability-zone)
    if [ $? -eq 0 ]; then
      TAGS+=(${AZ})
    fi

    INSTANCE_ID=$(wget -O - -q http://169.254.169.254/latest/meta-data/instance-id)
    if [ $? -eq 0 ]; then
      TAGS+=(${INSTANCE_ID})
    fi

    INSTANCE_TYPE=$(wget -O - -q http://169.254.169.254/latest/meta-data/instance-type)
    if [ $? -eq 0 ]; then
      TAGS+=(${INSTANCE_TYPE})
    fi

    set -e

    TAGS_STR=""
    if [ ${#TAGS[@]} -gt 0 ]; then
      TAGS_STR="-tags $(join , "${TAGS[@]}")"
      echo "==> Running registrator with ${TAGS_STR}"
    else
      echo "==> No AWS metadata found"
    fi

    shift
    set -- registrator ${TAGS_STR} "$@"
  fi
fi

exec "$@"
