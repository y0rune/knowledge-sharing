#!/bin/bash

################################################################################
#
# Marcin Wozniak
# 2023
#
# shellcheck disable=1091
################################################################################

set -u
set -e

# Colours
RED='\033[0;31m'
GREEN='\033[0;0;32m'
NC='\033[0m'

function timestamp() {
    echo -e "${GREEN}[+]${NC} $(date +'%F %T') [INFO] $*"
}

function err() {
    echo -e "${RED}[-] $(date +'%F %T') [ERROR] $*${NC}" >&2
}

function command_start() {
    timestamp "Command $* has been started."
    if ! "$@"; then
        err "Command $* went wrong."
        exit
    fi
    timestamp "Command $* has been ended."
}

function delete() {
    NUMBER_OF_CONTAINER=$(docker ps --all | grep -c ks-chinczyk)
    for i in $(seq -f "%02g" 1 "$NUMBER_OF_CONTAINER"); do
        NAME="ks-chinczyk-$i"
        docker stop "$NAME" > /dev/null 2>&1 &&
            docker rm "$NAME" > /dev/null 2>&1 &&
            timestamp "Container $NAME has been deleted."
    done
}

function create() {
    for i in $(seq -f "%02g" 1 "$NUMBER_OF_CONTAINER"); do
        NAME="ks-chinczyk-$i"
        docker run \
            --name "$NAME" \
            -d \
            -p "25$i":22 \
            ks-chinczyk > /dev/null 2>&1 &&
            timestamp "Container $NAME has been created."
    done
}

function main() {
    NUMBER_OF_CONTAINER="${2:-1}"
    [ "$1" = "delete" ] && command_start delete
    [ "$1" = "create" ] && command_start create
}

main "$@"
