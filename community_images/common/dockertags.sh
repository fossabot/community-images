#!/bin/bash
# This scripts fetchs all dockertags for a given repo

set +x # this script is very chatty, only change for tracing
set -e

if [ $# -ne 2 ]
then
cat << HELP

dockertags  --  list all tags for a Docker image on a remote registry.

EXAMPLE: 
    - list all php tags containing apache:
       dockertags php apache

HELP
fi

image="$1"
tags="$(wget -q https://registry.hub.docker.com/v1/repositories/"${image}"/tags -O -  | sed -e 's/[][]//g' -e 's/"//g' -e 's/ //g' | tr '}' '\n'  | awk -F: '{print $3}')"

SCRIPTPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

tags="$( echo "${tags}" | grep "$2" || true)"
if [ -z "$tags" ]; then
    echo "no matching tag"
    exit 0
fi

echo "${tags}" | python3 "${SCRIPTPATH}"/latest_tag.py "$2"
