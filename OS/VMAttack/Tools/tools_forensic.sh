#!/bin/bash
# Description:
#

function install_forensic_tools() {
  echo "[!] Installing sub-category \"forensic tools\""

  install_forensic_tools_volatility
}


function install_forensic_tools_volatility() {
  echo "[!] Installing volatility"
  $GIT clone "$URL_VOLATILITY"
}
