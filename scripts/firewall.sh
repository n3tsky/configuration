#!/bin/bash

if [ "$EUID" -ne 0 ]; then 
	echo "Please run as root"
	exit
fi

IPT="/sbin/iptables"
IPTS="/sbin/iptables-save"

# Flush
$IPT -F
$IPT -X
$IPT -t nat -F
$IPT -t nat -X
$IPT -t mangle -F
$IPT -t mangle -X

# Default policy
$IPT -P INPUT DROP
$IPT -P FORWARD DROP
$IPT -P OUTPUT DROP

# Allow related traffic
$IPT -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
$IPT -A OUTPUT -m state --state ESTABLISHED,RELATED -j ACCEPT

# Allow DNS rules
$IPT -A OUTPUT -p udp --dport 53 -m state --state NEW,ESTABLISHED -j ACCEPT
$IPT -A INPUT -p udp --sport 53 -m state --state ESTABLISHED -j ACCEPT

# Allow loopback
$IPT -A OUTPUT -o lo -j ACCEPT
$IPT -A INPUT -i lo -j ACCEPT

# Allow ICMP
$IPT -A OUTPUT -p icmp -m state --state NEW,ESTABLISHED,RELATED -j ACCEPT
$IPT -A INPUT -p icmp -m state --state ESTABLISHED,RELATED -j ACCEPT

# SSH
$IPT -A OUTPUT -p tcp --dport 22 -m state --state NEW,ESTABLISHED -j ACCEPT
$IPT -A INPUT -p tcp --sport 22 -m state --state ESTABLISHED -j ACCEPT

# HTTP/HTTPS
$IPT -A OUTPUT -p tcp -m multiport --dports 80,443 -m state --state NEW,ESTABLISHED -j ACCEPT
$IPT -A INPUT -p tcp -m multiport --sports 80,443 -m state --state ESTABLISHED -j ACCEPT

# FTP
$IPT -A OUTPUT -p tcp --dport 20:21 -m state --state NEW,ESTABLISHED -j ACCEPT
$IPT -A INPUT -p tcp --sport 20:21 -m state --state ESTABLISHED -j ACCEPT

# NTP
$IPT -A OUTPUT -p udp --dport 123 -m state --state NEW,ESTABLISHED -j ACCEPT
$IPT -A INPUT -p udp --sport 123 -m state --state ESTABLISHED -j ACCEPT

# Custom rules (work, server, etc.)
if [ -e "firewall_custom.sh" ]; then
	/bin/bash ./firewall_custom.sh
fi

# Block common attacks

# SYN scan
$IPT -A INPUT -p tcp ! --syn -m state --state NEW -j DROP
$IPT -A INPUT -m state --state INVALID -j DROP
$IPT -A INPUT -p tcp --tcp-flags ALL ACK,RST,SYN,FIN -j DROP 
$IPT -A INPUT -p tcp --tcp-flags SYN,FIN SYN,FIN -j DROP
$IPT -A INPUT -p tcp --tcp-flags SYN,RST SYN,RST -j DROP
$IPT -A INPUT -p tcp --tcp-flags ALL ALL -j DROP
$IPT -A INPUT -p tcp --tcp-flags ALL NONE -j DROP

# Drop all packets that are going to broadcast, multicast or anycast address.
$IPT -A INPUT -m addrtype --dst-type BROADCAST -j DROP
$IPT -A INPUT -m addrtype --dst-type MULTICAST -j DROP
$IPT -A INPUT -m addrtype --dst-type ANYCAST -j DROP
$IPT -A INPUT -d 224.0.0.0/4 -j DROP

# Block remote packets claiming to be from a loopback address.
$IPT -A INPUT -s 127.0.0.0/8 ! -i lo -j DROP

# Enable log
$IPT -A INPUT -j LOG
$IPT -A FORWARD -j LOG
$IPT -A OUTPUT -j LOG

$IPTS > /etc/iptables/rules.v4
