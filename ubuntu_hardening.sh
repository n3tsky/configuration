#!/bin/bash

echo "[!] Disable guest user and remote logon"
sudo sh -c 'printf "[SeatDefaults]\ngreeter-show-remote-login=false\n" >/usr/share/lightdm/lightdm.conf.d/50-no-remote-login.conf'
sudo sh -c 'printf "[SeatDefaults]\nallow-guest=false\n" >/usr/share/lightdm/lightdm.conf.d/50-no-guest.conf'

echo "[!] Hardening TCP/IP stack"
sudo echo "net.ipv4.icmp_echo_ignore_broadcasts = 1" >> /etc/sysctl.conf
sudo echo "net.ipv4.conf.all.accept_source_route = 0" >> /etc/sysctl.conf
sudo echo "net.ipv6.conf.all.accept_source_route = 0" >> /etc/sysctl.conf
sudo echo "net.ipv4.conf.default.accept_source_route = 0" >> /etc/sysctl.conf
sudo echo "net.ipv6.conf.default.accept_source_route = 0" >> /etc/sysctl.conf
sudo echo "net.ipv4.conf.all.send_redirects = 0" >> /etc/sysctl.conf
sudo echo "net.ipv4.conf.default.send_redirects = 0" >> /etc/sysctl.conf
sudo echo "net.ipv4.tcp_max_syn_backlog = 2048" >> /etc/sysctl.conf
sudo echo "net.ipv4.tcp_synack_retries = 2" >> /etc/sysctl.conf
sudo echo "net.ipv4.tcp_syn_retries = 5" >> /etc/sysctl.conf
sudo echo "net.ipv4.conf.all.log_martians = 1" >> /etc/sysctl.conf
sudo echo "net.ipv4.icmp_ignore_bogus_error_responses = 1" >> /etc/sysctl.conf
sudo echo "net.ipv4.conf.all.accept_redirects = 0" >> /etc/sysctl.conf
sudo echo "net.ipv6.conf.all.accept_redirects = 0" >> /etc/sysctl.conf
sudo echo "net.ipv4.conf.default.accept_redirects = 0" >> /etc/sysctl.conf
sudo echo "net.ipv6.conf.default.accept_redirects = 0" >> /etc/sysctl.conf
sudo echo "net.ipv4.icmp_echo_ignore_all = 1" >> /etc/sysctl.conf

echo "[!] Disable IPv6"
sudo echo "net.ipv6.conf.all.disable_ipv6 = 1" >> /etc/sysctl.conf
sudo echo "net.ipv6.conf.default.disable_ipv6 = 1" >> /etc/sysctl.conf
sudo echo "net.ipv6.conf.lo.disable_ipv6 = 1" >> /etc/sysctl.conf
sudo sysctl -p
#cat /proc/sys/net/ipv6/conf/all/disable_ipv6

echo "[!] Remove users"
for users in games gnats irc list news uucp; do
  sudo userdel -r "$users" 2> /dev/null
done

echo "[!] Shared memory"
sudo echo "tmpfs     /run/shm     tmpfs     defaults,noexec,nosuid     0     0" >> /etc/fstab

echo "[!] DNS"
sudo echo "nospoof on" >> /etc/host.conf

echo "[!] 'su' and shadow user"
read -p "   Username for current user: " mycurrentuser
read -p "   Username for shadow user: " myshadowuser
sudo useradd -d /home/$myshadowuser -s /bin/bash -m $myshadowuser
sudo usermod -a -G sudo $myshadowuser
sudo passwd $myshadowuser
sudo groupadd admin
sudo usermod -a -G admin $mycurrentuser
sudo dpkg-statoverride --update --add root admin 4750 /bin/su
#sudo passwd -l root

echo "[!] Disable ctrl+alt+del on ttys"
sudo systemctl mask ctrl-alt-del.target
sudo systemctl daemon-reload
