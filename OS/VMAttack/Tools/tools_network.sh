#!/bin/bash
# Description:
#

function install_network_tools() {
  echo "[!] Installing sub-category \"network tools\""

  install_network_tools_enum4linux
  install_network_tools_nmap
  install_network_tools_responder
}

# Install enum4linux + polenum
function install_network_tools_enum4linux() {
  echo "\t[!] Installing enum4linux"
  $MKDIR -p "$MY_DIRECTORY/network/enum4linux/"
  cd "$MY_DIRECTORY/network/enum4linux/"
  $WGET --quiet --no-check-certificate "$URL_ENUM4LINUX"
  $TAR -xvf "enum4linux-0.8.9.tar.gz"
  $RM "enum4linux-0.8.9.tar.gz"
  cd enum4linux-0.8.9

  echo "\t[!] Installing polenum"
  $WGET --quiet --no-check-certificate "$URL_POLENUM"
  $TAR -xvfj "polenum-0.2.tar.bz2"
  $MV "polenum-0.2/polenum.py" .
  $RM "polenum-0.2.tar"
  $RM -rf "polenum-0.2"
}

# Install nmap tools
function install_network_tools_nmap() {
  echo "\t[!] Installing nmap"
  $MKDIR -p "$MY_DIRECTORY/network/nmap/"
  cd "$MY_DIRECTORY/network/nmap/"
  $WGET --quiet --no-check-certificate "$URL_NMAP" -O "nmap.tar.bz2"
  $TAR -xvfj "nmap.tar.bz2"
  $RM "nmap.tar.bz2"
  cd "nmap-7.60"
  ./configure && $MAKE && sudo $MAKE install
}

function install_network_tools_responder() {
  echo "\t[!] Installing Responder"
  $GIT clone "$URL_RESPONDER"
}
