#!/bin/bash 

DIR=$(dirname "$(readlink -f "$0")")
. $DIR/conf.sh

is_running () {
	[ "$(VBoxManage list runningvms | grep $vm_name)" != "" ]
}

wait_for_disappear () {
	if is_running; then
		echo "Waiting $vm_name for disappear"
	fi
        while is_running; do
                sleep 10
        done
}

vm_suspend() {
	if is_running; then 
		echo "Suspending $vm_name..."
		VBoxManage controlvm $vm_name savestate
		exit 0
	fi
}

trap vm_suspend INT

while : ; do 
	wait_for_disappear
	echo "Starting $vm_name (user: $(whoami))"
	VBoxManage startvm $vm_name --type headless
done
