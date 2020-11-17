#!/bin/bash
#bash script to reconfigure some stuff for cloned ubuntu vm's
#constant variables
pref_tz="America/New_York";


#remove and re-create ssh host keys
echo "[INFO] removing host ssh keys";
rm -v /etc/ssh/ssh_host_*;
dpkg-reconfigure openssh-server;
service ssh restart;
echo "[INFO] SSH host keys regenerated";

#ask to reconfigure timezone if not currently set to preferred above
read cur_tz < /etc/timezone;
if [ cur_tz != pref_tz ]
then
	echo "[INFO] Current time zone not set to preferred...running tz reconfigure...";
	dpkg-reconfigure tzdata;
	cat /etc/timezone;
fi


#set new local host name
echo "[INFO] Reading current hostname from file";
read oldhost < /etc/hostname
echo "[INFO] Current host name is : $oldhost";
echo "[INFO] Setting new hostname";
echo -n "Please enter new hostname: ";
read hostnm;
echo "[INFO] Host name being set to $hostnm...";
hostnamectl set-hostname $hostnm;
echo "[INFO] updating /etc/hosts...";
sed "s/$oldhost/$hostnm/" /etc/hosts;
#insert sed command here to edit /etc/hosts

echo "...done.";

echo "Hosts file printout:";
echo "====================";
cat /etc/hosts;

#run apt updates?
echo -n "Do you want to run apt updates now? (Y/n";
read -n 1 answer;
#insert code here to check if entered n or N or if Y nothing entered default to Y

if [ -z answer ] || [ answer == 'y' ] || [ answer =='Y' ]
then
	#run updates
	echo "[INFO] Running updates...";
	apt update && apt upgrade -y;
else
	#dont run updates
	echo "[INFO] skipping updates.";
fi
