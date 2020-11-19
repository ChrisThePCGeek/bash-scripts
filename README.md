# bash-scripts
Bash Scripts for running on linux

# clonesetup.sh (tested to work on Ubuntu 20.04 server)
This file runs some common tasks as a batch job when creating clones of a base ubuntu server install.  Things like changing the host SSH keys and making sure timezone is correct, changing the hostname, proving user the option to run any updates, and probably more stuff too once I think of adding them in.  Not bad for my first ever Bash script.
## Useage:
    You can run this by using the below curl command or if you can't copy/paste into the console like on a VM for example, see below for directions on using the little helper script run-clonesetup.sh

`Curl command : <sudo bash -c "$(curl -f sSL https://raw.githubusercontent.com/ChrisThePCGeek/bash-scripts/main/clonesetup.sh)">`

# run-clonesetup.sh
This file you download and save to either your /root folder or in your user's home directory on the base install vm.  chmod it with a+x so it can be ran when you boot up a clone from the base install snapshot/vm.  It just pulls down the above script and executes it to ensure it's the most recent version.