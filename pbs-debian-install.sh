#!/bin/bash
echo "deb http://download.proxmox.com/debian/pbs bookworm pbs-no-subscription" | sudo tee -a /etc/apt/sources.list
sudo apt install wget -y
wget https://enterprise.proxmox.com/debian/proxmox-release-bookworm.gpg -O /etc/apt/trusted.gpg.d/proxmox-release-bookworm.gpg
sudo apt update && apt upgrade -y
sudo apt install -y whiptail apt-utils coreutils bash proxmox-widget-toolkit nano nfs-common
sudo apt update && apt install proxmox-backup -y
echo "https://$(ip -4 addr show $(ip route | grep default | awk '{print $5}') | grep inet | awk '{print $2}' | cut -d/ -f1):8007"
passwd root