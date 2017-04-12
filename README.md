# Usage 

1. Download control scripts: 

```bash
cd /path/to/your-virtual-machine
git clone https://github.com/ceremcem/vbox-headless-control
cd vbox-headless-control
```
2. Check if VM name is correctly determined: 

```
./conf.sh 
=> Should print "VM name: your-virtual-machine"
```

3. In order to start your virtual machine, run: 
```
./keep-up-headless.sh
```

If this script is killed (via `INT` signal, eg. with Ctrl+C), it triggers the `savestate` action for the VM. 

4. If you want to take a snapshot, run 
```
./take-snapshot.sh [LIMIT FOR LAST SNAPSHOT]
```
`take-snapshot.sh` will take a snapshot. if "LIMIT FOR LAST SNAPSHOT" parameter is provided, then script will 
check the last snapshot file (the one in use) and if the file size is bigger than this limit, it will take a snapshot, 
else it does nothing. 

