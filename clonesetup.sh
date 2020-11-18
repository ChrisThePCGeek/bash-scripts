#!/bin/bash
#bash script to reconfigure some stuff for cloned ubuntu vm's
#constant variables
pref_tz="America/New_York";
wget "https://raw.githubusercontent.com/ChrisThePCGeek/bash-scripts/main/shell_colors";
. shell_colors;

#remove and re-create ssh host keys
echo -e "${BYellow}[INFO]${BGreen} removing host ssh keys${NC}";
rm -v /etc/ssh/ssh_host_*;
dpkg-reconfigure openssh-server;
service ssh restart;
echo -e "${BYellow}[INFO]${BGreen} SSH host keys regenerated${NC}";

#ask to reconfigure timezone if not currently set to preferred above
read cur_tz < /etc/timezone;
echo -e "${BYellow}[INFO]${BGreen} Checking to see if timezone is set to preferred as configured in script...${NC}"
if [ "$cur_tz" != "$pref_tz" ]
then
	echo -e "${BYellow}[INFO]${BGreen} Current time zone not set to preferred...running tz reconfigure...${NC}";
	dpkg-reconfigure tzdata;
	cat /etc/timezone;
else
	echo -e "${BYellow}[INFO]${BGreen} Current time zone is set to preferred,${NC} $cur_tz";
fi
echo "================"
echo
#set new local host name
echo -e "${BYellow}[INFO]${BGreen} Reading current hostname from file${NC}";
read oldhost < /etc/hostname
echo -e "${BYellow}[INFO]${BGreen} Current host name is : $oldhost${NC}";
echo "."
echo -e "${BYellow}[INFO]${BGreen} Setting new hostname";
echo -n "  Please enter new hostname: ";
read hostnm;
echo -e "${BYellow}[INFO]${BGreen} Host name being set to $hostnm...${NC}";
hostnamectl set-hostname $hostnm;
echo -e "${BYellow}[INFO]${BGreen} updating /etc/hosts...${NC}";
sed -i "s/$oldhost/$hostnm/" /etc/hosts;
#insert sed command here to edit /etc/hosts
echo;
echo "...done.";

echo "Hosts file printout:";
echo "====================";
cat /etc/hosts;

#run apt updates?
echo -n "Do you want to run apt updates now? (Y/n";
read -n 1 answer;

if [ -z "$answer" ] || [ "$answer" = "y" ] || [ "$answer" = "Y" ]
then
	#run updates
	echo -e "${BYellow}[INFO]${BGreen} Running updates...${NC}";
	apt update && apt upgrade -y;
else
	#dont run updates
	echo -e "${BYellow}[INFO]${BGreen} skipping updates.${NC}";
fi

#reset answer variable
answer="";

#reboot the server?
echo -n "Do you want to reboot now? (Y/n";
read -n 1 answer;

if [ -z "$answer" ] || [ "$answer" = "y" ] || [ "$answer" = "Y" ]
then
	#run updates
	echo -e "${BYellow}[INFO]${BGreen} rebooting...${NC}";
	reboot;
else
	#dont run updates
	echo -e "${BYellow}[INFO]${BGreen} not rebooting. Please remember to reboot to apply changes just made.${NC}";
fi
