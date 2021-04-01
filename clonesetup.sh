#!/bin/bash
#bash script to reconfigure some stuff for cloned ubuntu vm's
#tested and known to work on Ubuntu-server 20.04
#======================================================
#Created by ThePCGeek https://github.com/ChrisThePCGeek
#======================================================


#these are constants for the color escape sequences
#======================================
# Reset
NC='\033[0m'       # Text Reset
# Bold
BBlack='\033[1;30m'       # Black
BRed='\033[1;31m'         # Red
BGreen='\033[1;32m'       # Green
BYellow='\033[1;33m'      # Yellow
BBlue='\033[1;34m'        # Blue
BPurple='\033[1;35m'      # Purple
BCyan='\033[1;36m'        # Cyan
BWhite='\033[1;37m'       # White
# Regular Colors
Black='\033[0;30m'        # Black
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Yellow='\033[0;33m'       # Yellow
Blue='\033[0;34m'         # Blue
Purple='\033[0;35m'       # Purple
Cyan='\033[0;36m'         # Cyan
White='\033[0;37m'        # White
#=======================================

#remove and re-create ssh host keys
echo -e "${BYellow}[INFO]${BGreen} removing host ssh keys${NC}";
rm -v /etc/ssh/ssh_host_*;
#dpkg-reconfigure openssh-server;
ssh-keygen -A; #regenerate host SSH keys without re-configuring using dpkg
service ssh restart;
echo -e "${BYellow}[INFO]${BGreen} SSH host keys regenerated${NC}";

#ask to reconfigure timezone if not currently set to preferred above
read cur_tz < /etc/timezone;
echo -e "${BYellow}[INFO]${BGreen} Current TimeZone is...${BRed} $cur_tz ${NC}";
echo -n "Would you like to select a different time zone? (N/y)";
read -n 1 tzans;
if [ "$tzans" =~ "[yY]" ]
then
	echo -e "${BYellow}[INFO]${BGreen}...running tz reconfigure...${NC}";
	dpkg-reconfigure tzdata;
	echo  -n -e "${BYellow}[INFO] TimeZone change to ${BRed}";
	cat /etc/timezone;
	echo -e "\n${NC} ";
else
	echo -e "${BYellow}[INFO]${BGreen} Current time zone,${BRed} $cur_tz ${BGreen}, will remain unchanged.${NC}";
fi
echo "================"
echo
#set new local host name
echo -e "${BYellow}[INFO]${BGreen} Reading current hostname from file${NC}";
read oldhost < /etc/hostname
echo -e "${BYellow}[INFO]${BGreen} Current host name is : ${BRed}$oldhost${NC}";
echo "."
echo -e "${BYellow}[INFO]${BGreen} Setting new hostname${NC}";
echo -n "  Please enter new hostname: ";
read hostnm;
echo -e "\n${BYellow}[INFO]${BGreen} Host name being set to ${BRed}$hostnm...${NC}";
hostnamectl set-hostname $hostnm;
echo -e "${BYellow}[INFO]${BGreen} updating /etc/hosts...${NC}";
sed -i "s/$oldhost/$hostnm/" /etc/hosts;
#insert sed command here to edit /etc/hosts
echo;
echo "...done.";

echo "Hosts file printout:";
echo -e "${BPurple} ====================";
cat /etc/hosts;
echo -e "==================== ${NC}\n";

#run apt updates?
echo -n "Do you want to run apt updates now? (Y/n)";
read -n 1 answer;

if [ -z "$answer" ] || [ "$answer" =~ "[yY]" ]
then
	#run updates
	echo -e "\n${BYellow}[INFO]${BGreen} Running updates...${NC}";
	apt update && apt upgrade -y;
else
	#dont run updates
	echo -e "\n${BYellow}[INFO]${BGreen} skipping updates.${NC}";
fi

#reset answer variable
answer="";

#reboot the server?
echo -n "Do you want to reboot now? (Y/n)";
read -n 1 answer;

if [ -z "$answer" ] || [ "$answer" =~ "[yY]" ]
then
	#run updates
	echo -e "\n${BYellow}[INFO]${BGreen} rebooting...${NC}";
	reboot;
else
	#dont run updates
	echo -e "\n${BYellow}[INFO]${BGreen} not rebooting. Please remember to reboot to apply changes just made.${NC}";
fi
