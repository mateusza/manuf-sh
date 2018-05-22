#!/bin/bash

MANUF_FILE="/usr/share/wireshark/manuf"

usage(){
    echo "usage: $1 MAC" > /dev/stderr
}

error(){
    echo "Incorrect MAC prefix" > /dev/stderr
    exit 1
}

main(){
    echo "$1" | grep "^[0-9a-fA-F:]\+$" > /dev/null || error
    PREFIX=$( echo "$1" | tr a-f A-F )
    echo "Searching: $PREFIX" > /dev/stderr
    grep "^$PREFIX" "$MANUF_FILE"
    if [ "$?" == 0 ]
    then
        true
    else
        echo "Not found"
    fi
}

if [ "$#" == 0 ]
then
    usage "$0"
else
    main "$1"
fi
