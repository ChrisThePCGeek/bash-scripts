#!/bin/bash
#this script lives inside my vm base image and runs the version of clonesetup.sh that is on the github

bash -c "$(curl -f sSL https://raw.githubusercontent.com/ChrisThePCGeek/bash-scripts/main/clonesetup.sh)";

