#!/bin/bash 

DIR=$(dirname "$(readlink -f "$0")")


export vm_name=$(cat $DIR/../*.vbox | grep "<Machine" | grep -oP 'name="\K[^"]*')
export SNAP_DIR=$DIR/../Snapshots

echo "VM name is: $vm_name"

