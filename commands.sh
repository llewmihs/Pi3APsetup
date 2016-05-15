#!/bin/bash

echo "Installing the necessary dependencies"
sudo apt-get install hostapd dnsmasq -y


echo "What IP would you like to use? [format xxx.xxx.xxx]"
read ip_variable
echo "interface wlan0
    static ip_address=$ip_variable.1/24" >> /etc/dhcpcd.conf



# this part of the shell script needs to comment out the wpa_supplicant conf from /etc/network/interfaces wlan0

#Configure HOSTAPD
echo "Which SSID would you like to use?"
read new_SSID
echo "Set a assword for the wireless network:"
read new_password
echo "interface=wlan0
driver=nl80211
ssid=$new_SSID
hw_mode=g
channel=6
ieee80211n=1
wmm_enabled=1
ht_capab=[HT40][SHOR-GI-20][DSSS_CCK-40]
macaddr_algs=1
auth_algs=1
ignore_broadcast_ssid=0
wpa=2
wpa_passphrase=$new_password
rsn_pairwise=CCMP" >> $new_SSID.conf
sudo mv $new_SSID.conf /etc/hostapd/hostapd.conf

sudo mv /etc/default/hostapd /etc/default/hostapd.orig
sudo echo "DAEMON_CONF=\"/etc/hostapd/hostapd.conf\"" >> hostapd
sudo mv hostapd /etc/default/hostapd

# move the original dnsmasq file fo safe keeping
sudo mv /etc/dnsmasq.conf /etc/dnsmasq.conf.orig
echo "interface=wlan0
bind-interfaces
server=8.8.8.8
domain-needed
bogus-priv
dhcp-range=$ip_variable.50,$ip_variable.100,12h" >> newdns.conf
sudo mv newdns.conf /etc/dnsmasq.conf



#sudo sed -i "/\b\(interface wlan0\|static ipaddress=111.111.11.11\)\b/d" /etc/dhcpcd.conf

