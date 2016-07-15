#!/bin/bash

read -p "[!] Username: " myname
clear

mydirectory="/home/$myname/Tools/"
mkdir -p $mydirectory
cd $mydirectory

echo "[!] System updates"
sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt-get dist-upgrade -y

echo "[!] Remove default useless apps..."
sudo apt-get remove -y --purge rhythmbox ekiga totem ubuntu-one unity-lens-music unity-lens-photos unity-lens-video transmission transmission-gtk thunderbird apport

echo "[!] Remove of search tools provided by unity."
gsettings set com.canonical.Unity.Lenses disabled-scopes "['more_suggestions-amazon.scope', 'more_suggestions-u1ms.scope', 'more_suggestions-populartracks.scope', 'music-musicstore.scope', 'more_suggestions-ebay.scope', 'more_suggestions-ubuntushop.scope', 'more_suggestions-skimlinks.scope']"
gsettings set com.canonical.Unity.Lenses remote-content-search none

echo "[!] Disable guest user and remote logon"
sudo sh -c 'printf "[SeatDefaults]\ngreeter-show-remote-login=false\n" >/usr/share/lightdm/lightdm.conf.d/50-no-remote-login.conf'
sudo sh -c 'printf "[SeatDefaults]\nallow-guest=false\n" >/usr/share/lightdm/lightdm.conf.d/50-no-guest.conf'

echo "[!] Install hacking tools and other tools"
sudo apt-get install -y aptitude vim nbtscan wireshark-qt tshark dsniff tcpdump openjdk-8-jre libssl-dev libmysqlclient-dev libjpeg-dev libnetfilter-queue-dev ettercap-text-only pidgin pidgin-otr traceroute lft gparted autopsy gnupg htop ssh libpcap0.8-dev libimage-exiftool-perl p7zip p7zip-full proxychains curl terminator hydra hydra-gtk medusa libtool rdesktop bzip2 rpcbind gimp steghide whois aircrack-ng cmake gdb stunnel hping3 vncviewer scalpel foremost unrar rar secure-delete libpq-dev samba smbclient

echo "[!] Install ruby and dependances"
sudo apt-get install -y ruby ruby-dev bundler

echo "[!] Install python and requirements"
sudo apt-get install -y php7.0-cli php7.0-curl python-pil python-pycurl python-magic python-requests python-openssl python-pypcap python-crypto python-cryptography python-dev python-scapy python-urllib3 python-distorm3 python-impacket python-pcapy

echo "[!] Install dev libs"
sudo apt-get install -y libssl-dev zlib1g-dev libxml2-dev libxslt1-dev libyaml-dev libssh-dev libsqlite-dev libsqlite3-dev libpcap-dev libcurl4-openssl-dev

echo "[!] Install some other tools"
sudo apt-get install -y git git-core qemu-kvm qemu-utils binwalk qemu-system* build-essential autoconf postgresql pgadmin3 curl keepassx

echo "[!] Create tools directory (and subdirectories)"
cd $mydirectory/
mkdir -p $mydirectory/cheatsheets
mkdir -p $mydirectory/network
mkdir -p $mydirectory/database
mkdir -p $mydirectory/web
mkdir -p $mydirectory/exploits
mkdir -p $mydirectory/mobile
mkdir -p $mydirectory/wordlists
mkdir -p $mydirectory/escalation
mkdir -p $mydirectory/pwcracking
mkdir -p $mydirectory/reverse
mkdir -p $mydirectory/recon
mkdir -p $mydirectory/wireless
mkdir -p $mydirectory/windows
mkdir -p $mydirectory/linux
mkdir -p $mydirectory/forensics


echo "[!] Install enum4linux"
mkdir -p $mydirectory/network/enum4linux
cd $mydirectory/network/enum4linux
wget -nc "https://labs.portcullis.co.uk/download/enum4linux-0.8.9.tar.gz"
tar -xvf enum4linux-0.8.9.tar.gz
rm enum4linux-0.8.9.tar.gz
cd enum4linux-0.8.9
wget -nc "https://labs.portcullis.co.uk/download/polenum-0.2.tar.bz2"
bzip2 -d polenum-0.2.tar.bz2
tar -xvf polenum-0.2.tar
mv polenum-0.2/polenum.py .
rm polenum-0.2.tar
rm -rf polenum-0.2
cd $mydirectory

echo "[!] Install network tools"
cd $mydirectory/network/
git clone https://github.com/SpiderLabs/Responder.git
mkdir -p $mydirectory/network/nmap
cd $mydirectory/network/nmap
wget -nc https://nmap.org/dist/nmap-7.12.tar.bz2
bzip2 -d nmap-7.12.tar.bz2
tar -xvf nmap-7.12.tar
rm nmap-7.12.tar
cd nmap-7.12
./configure && make && sudo make install
cd $mydirectory

echo "[!] Install reconnaissance tools"
cd $mydirectory/recon
git clone https://github.com/laramies/theHarvester.git
cd $mydirectory

echo "[!] Install privesc tools"
cd $mydirectory/escalation
git clone https://github.com/mattifestation/PowerSploit.git
git clone https://github.com/PowerShellEmpire/PowerTools.git
git clone https://github.com/Kevin-Robertson/Inveigh.git
git clone https://github.com/samratashok/nishang.git
mkdir -p $mydirectory/escalation/wcedigest/x86
mkdir -p $mydirectory/escalation/wcedigest/x64
cd $mydirectory/escalation/wcedigest
wget -nc http://www.ampliasecurity.com/research/wce_v1_42beta_x32.zip
wget -nc http://www.ampliasecurity.com/research/wce_v1_42beta_x64.zip
unzip wce_v1_42beta_x32.zip -d x86
unzip wce_v1_42beta_x64.zip -d x64
rm wce_v1_42beta_x32.zip
rm wce_v1_42beta_x64.zip
cd $mydirectory

echo "[!] Install mimikatz"
mkdir -p $mydirectory/escalation/mimikatz
cd $mydirectory/escalation/mimikatz
wget -nc https://github.com/gentilkiwi/mimikatz/releases/download/2.1.0-alpha-20160711/mimikatz_trunk.zip
unzip -o mimikatz_trunk.zip
rm mimikatz_trunk.zip
cd $mydirectory

echo "[!] Install volatility framework"
cd $mydirectory/forensics
git clone https://github.com/volatilityfoundation/volatility.git
cd $mydirectory

echo "[!] Install passord cracking tools"
cd $mydirectory/pwcracking/
mkdir -p mkdir -p $mydirectory/pwcracking/cewl
cd $mydirectory/pwcracking/cewl
wget -nc "https://digi.ninja/files/cewl_5.1.tar.bz2"
cd $mydirectory/pwcracking/
git clone https://github.com/Mebus/cupp.git
git clone https://github.com/magnumripper/JohnTheRipper.git
cd JohnTheRipper/src
./configure && make -s clean && make -sj4
cd $mydirectory

echo "[!] Install exploit related tools"
cd $mydirectory/exploits
git clone https://github.com/offensive-security/exploit-database
#git clone https://github.com/madmantm/powershell
cd $mydirectory

echo "[!] Install database tools"
cd $mydirectory/database
git clone https://github.com/sqlmapproject/sqlmap.git
wget -nc "https://www.dbvis.com/product_download/dbvis-9.5/media/dbvis_linux_9_5.deb"
sudo dpkg -i dbvis_linux_9_5.deb
rm dbvis_linux_9_5.deb
cd $mydirectory

echo "[!] Install web tools"
cd $mydirectory/web
git clone https://github.com/wpscanteam/wpscan.git
git clone https://github.com/vs4vijay/heartbleed.git
git clone https://github.com/sullo/nikto.git
git clone https://github.com/WebBreacher/tilde_enum.git
git clone https://github.com/xmendez/wfuzz
wget -nc "http://downloads.sourceforge.net/project/dirbuster/DirBuster%20%28jar%20%2B%20lists%29/1.0-RC1/DirBuster-1.0-RC1.tar.bz2?r=http%3A%2F%2Fsourceforge.net%2Fprojects%2Fdirbuster%2Ffiles%2FDirBuster%2520%2528jar%2520%252B%2520lists%2529%2F1.0-RC1%2F&ts=1443459199&use_mirror=iweb" -O DirBuster-1.0-RC1.tar.bz2
bunzip2 DirBuster-1.0-RC1.tar.bz2
tar -xvf DirBuster-1.0-RC1.tar
rm DirBuster-1.0-RC1.tar

echo "[!] Other exploit tools"
cd $mydirectory/exploits
git clone https://github.com/PenturaLabs/Linux_Exploit_Suggester.git
git clone https://github.com/GDSSecurity/Windows-Exploit-Suggester.git
git clone https://github.com/trustedsec/unicorn
cd $mydirectory

echo "[!] Install gems"
sudo gem install snmp
sudo gem install pcaprub
sudo gem install rake
sudo gem install bettercap

echo "[!] Gather the metasploit repository"
cd $mydirectory/exploits
git clone https://github.com/rapid7/metasploit-framework.git
cd $mydirectory/exploits/metasploit-framework
bundle install
cd $mydirectory

echo "[!] Fix user rights"
chown -R $myname:$myname $mydirectory

echo "[!] Clean packages downloaded"
sudo aptitude autoclean -y
sudo apt-get autoremove --purge

echo "### Done ###"
