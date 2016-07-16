#!/bin/bash

echo "[!] Disable guest user and remote logon"
sudo sh -c 'printf "[SeatDefaults]\ngreeter-show-remote-login=false\n" >/usr/share/lightdm/lightdm.conf.d/50-no-remote-login.conf'
sudo sh -c 'printf "[SeatDefaults]\nallow-guest=false\n" >/usr/share/lightdm/lightdm.conf.d/50-no-guest.conf'

echo "[!] Hardening TCP/IP stack"
echo "net.ipv4.icmp_echo_ignore_broadcasts = 1" >> /etc/sysctl.d/10-network-security.conf
echo "net.ipv4.conf.all.accept_source_route = 0" >> /etc/sysctl.d/10-network-security.conf
echo "net.ipv6.conf.all.accept_source_route = 0" >> /etc/sysctl.d/10-network-security.conf
echo "net.ipv4.conf.default.accept_source_route = 0" >> /etc/sysctl.d/10-network-security.conf
echo "net.ipv6.conf.default.accept_source_route = 0" >> /etc/sysctl.d/10-network-security.conf
echo "net.ipv4.conf.all.send_redirects = 0" >> /etc/sysctl.d/10-network-security.conf
echo "net.ipv4.conf.default.send_redirects = 0" >> /etc/sysctl.d/10-network-security.conf
echo "net.ipv4.tcp_max_syn_backlog = 2048" >> /etc/sysctl.d/10-network-security.conf
echo "net.ipv4.tcp_synack_retries = 2" >> /etc/sysctl.d/10-network-security.conf
echo "net.ipv4.tcp_syn_retries = 5" >> /etc/sysctl.d/10-network-security.conf
echo "net.ipv4.conf.all.log_martians = 1" >> /etc/sysctl.d/10-network-security.conf
echo "net.ipv4.icmp_ignore_bogus_error_responses = 1" >> /etc/sysctl.d/10-network-security.conf
echo "net.ipv4.conf.all.accept_redirects = 0" >> /etc/sysctl.d/10-network-security.conf
echo "net.ipv6.conf.all.accept_redirects = 0" >> /etc/sysctl.d/10-network-security.conf
echo "net.ipv4.conf.default.accept_redirects = 0" >> /etc/sysctl.d/10-network-security.conf
echo "net.ipv6.conf.default.accept_redirects = 0" >> /etc/sysctl.d/10-network-security.conf
echo "net.ipv4.icmp_echo_ignore_all = 1" >> /etc/sysctl.d/10-network-security.conf

service procps start

echo "[!] Disable IPv6"
echo "net.ipv6.conf.all.disable_ipv6 = 1" >> /etc/sysctl.conf
echo "net.ipv6.conf.default.disable_ipv6 = 1" >> /etc/sysctl.conf
echo "net.ipv6.conf.lo.disable_ipv6 = 1" >> /etc/sysctl.conf
sudo sysctl -p
