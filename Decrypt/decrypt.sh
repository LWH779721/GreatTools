#!/bin/bash

if [ $# -ne 2 ]
then
    echo "usage:$0 src dst"
    exit 1
fi

authbash "cat $1" | cat > $2