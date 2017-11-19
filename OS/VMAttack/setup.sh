#!/bin/bash

# Variables
MY_DIRECTORY="/home/blob/Tools"

# PATH to binaries
GIT="/usr/bin/git"
MAKE="/usr/bin/make"
MKDIR="/bin/mkdir"
MV="/bin/mv"
RM="/bin/rm"
TAR="/bin/tar"
WGET="/usr/bin/wget"

# main

# Create directories
for dir in "cheatsheets network database web exploits mobile wordlists escalation pwcracking reverse wireless forensic"; do
  $MKDIR -p "$MY_DIRECTORY/$dir"
done

# Go through install
install_network_tools
