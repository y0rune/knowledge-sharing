#!/bin/bash

NUMBER_OF_CONTAINER="20"

function delete() {
    for i in $(seq -f "%02g" 1 "$NUMBER_OF_CONTAINER"); do
        NAME="chinczyk-knowledge-sharing-$i"
        sudo docker stop "$NAME" > /dev/null 2>&1
        sudo docker rm "$NAME" > /dev/null 2>&1
    done
}

function create() {
    for i in $(seq -f "%02g" 1 "$NUMBER_OF_CONTAINER"); do
        NAME="chinczyk-knowledge-sharing-$i"
        sudo docker run \
            --name "$NAME" \
            -d \
            -p "22$i":22 \
            -p "80$i":80 \
            chinczyk-knowledge-sharing-v2 > /dev/null 2>&1

    done
}

function main() {
    [ "$1" = "delete" ] && delete
    [ "$1" = "create" ] && create
}

main "$@"
