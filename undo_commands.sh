#!/bin/bash

sudo rm /etc/hostapd/hostapd.conf
sudo cp /etc/default/hostapd.orig /etc/default/hostapd
sudo rm /etc/default/hostapd.orig
sudo cp /etc/dnsmasq.conf.orig /etc/dnsmasq.conf
sudo rm /etc/dnsmasq.conf.orig
sudo sed -i "/\b\(interface wlan0\|static ipaddress=111.111.11.11\)\b/d" /etc/dhcpcd.conf

