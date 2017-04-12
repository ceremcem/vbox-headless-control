#!/bin/bash 

DIR=$(dirname "$(readlink -f "$0")")


export vm_name=$(grep "<Machine" "$DIR/../"*.vbox | grep -oP 'name="\K[^"]*')

if [ "$vm_name" == "" ]; then 
    echo "Can not find VM name!"
    exit 1
fi 

export SNAP_DIR="$DIR/../Snapshots"

echo "VM name is: $vm_name"

