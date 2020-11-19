# bash-scripts
Bash Scripts for running on linux

## clonesetup.sh (tested to work on Ubuntu 20.04 server)
This file runs some common tasks as a batch job when creating clones of a base ubuntu server install.  Things like changing the host SSH keys and making sure timezone is correct, changing the hostname, proving user the option to run any updates, and probably more stuff too once I think of adding them in.  Not bad for my first ever Bash script.
### Useage:
You can run this by using the below curl command or if you can't copy/paste into the console like on a VM for example, see below for directions on using the little helper script run-clonesetup.sh

    `Curl command : <sudo bash -c "$(curl -f sSL https://raw.githubusercontent.com/ChrisThePCGeek/bash-scripts/main/clonesetup.sh)">`

## run-clonesetup.sh
1. Download to user's home directory or /root
1. `chmod +x /path/run-clonesetup.sh`
1. to run type `sudo /path/run-clonesetup.sh`
