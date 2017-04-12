#!/bin/bash 

DIR=$(dirname "$(readlink -f "$0")")
. $DIR/conf.sh

SIZE_LIMIT=$1
if [[ "$SIZE_LIMIT" == "" ]]; then 
	echo "usage: $0 SIZE_LIMIT"
	exit
fi

curr_vdi_uuid=$(VBoxManage snapshot "aktos-1.6-backup" list --machinereadable | grep CurrentSnapshotUUID | awk -F= '{print $NF}') 

echo "Curr snapshot's UUID: $curr_vdi_uuid"
VBoxManage snapshot $vm_name showvminfo $curr_vdi_uuid
exit

DATE=`date +%Y%m%d.%H%M%S`

echo "Taking snapshot of $vm_name with name $DATE"
#/usr/bin/VBoxManage snapshot "$vm_name" take "$DATE" --description "Periodic snapshot by $0"
