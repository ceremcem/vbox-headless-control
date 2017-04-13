#!/bin/bash 

DIR=$(dirname "$(readlink -f "$0")")
. "$DIR/conf.sh"

SIZE_LIMIT=$1
if [[ "$SIZE_LIMIT" == "" ]]; then 
	SIZE_LIMIT=0
fi

## BACKUP: Seems this has no effect
#curr_vdi_uuid=$(VBoxManage snapshot "$vm_name" list --machinereadable | grep CurrentSnapshotUUID | awk -F= '{print $NF}') 
#echo "Curr snapshot's UUID: $curr_vdi_uuid"
## END OF BACKUP 

RW_FILE_SIZE=0
while read -rd $'\0' vdi_file; do
	if [ "$(VBoxManage showhdinfo $vdi_file | grep 'locked write')" != "" ]; then 
		file_size=`du -m "$vdi_file" | cut -f1`
		echo "VDI file: $(basename $vdi_file) ($file_size MB)"
		RW_FILE_SIZE=$file_size
	fi
done < <( find $SNAP_DIR -iname "*.vdi" -print0 )

if [[ $RW_FILE_SIZE > $SIZE_LIMIT ]]; then 
	echo "Filesize exceeds given limit, taking snapshot..."
else
	echo "Filesize is smaller than given limit, not taking snapshot..."
	exit 0
fi

DATE=`date +%Y%m%d.%H%M%S`

echo "Taking snapshot of $vm_name with name $DATE"
/usr/bin/VBoxManage snapshot "$vm_name" take "$DATE" --description "Periodic snapshot by $0"
