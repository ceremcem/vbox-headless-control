#!/bin/bash 

DIR=$(dirname "$(readlink -f "$0")")
. $DIR/conf.sh

wait_for_disappear () {
        while [ "$(VBoxManage list runningvms | grep $vm_name)" != "" ]
        do 
                echo "waiting $vm_name for disappear..."
                sleep 10
        done
}

vm_shutdown() {
	# TODO: 
	# * check only THIS virtual machine if it is alive
	# * really send the acpi shutdown signal
	echo "ACPI shutdown the machine"
	VBoxManage controlvm $vm_name acpipowerbutton
	exit
}

#trap vm_shutdown INT

while : ; do 
	wait_for_disappear
	echo "Starting $vm_name (user: $(whoami))"
	/usr/bin/VBoxHeadless --startvm "$vm_name"
done
