#!/bin/bash
# Description:
#

function install_database_tools() {
  echo "[!] Installing sub-category \"database tools\""

  install_database_tools_sqlmap
  install_database_tools_dbvis
}

function install_database_tools_sqlmap() {
  echo "\t[!] Installing sqlmap"
  $GIT clone "$URL_SQLMAP"
}

function install_database_tools_dbvis() {
  echo "\t[!] Installing dbvis"
  $WGET "$URL_DBVIS"
}
