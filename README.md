# bash-scripts
Bash Scripts for running on linux

# clonesetup.sh
this file runs some common tasks as a batch job when creating clones of a base ubuntu server install.  Things like changing the host SSH keys and making sure timezone is correct, changing the hostname, proving user the option to run any updates, and probably more stuff too once I think of adding them in.  Not bad for my first ever Bash script.

# run-clonesetup.sh
This file you download and save to either your /root folder or in your user's home directory on the base install vm.  chmod it with a+x so it can be ran when you boot up a clone from the base install snapshot/vm.  It just pulls down the above script and executes it to ensure it's the most recent version.