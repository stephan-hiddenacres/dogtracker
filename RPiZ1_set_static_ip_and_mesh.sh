#!/bin/bash

# Update and install necessary packages for BATMAN-adv
sudo apt update
sudo apt install -y batctl wireless-tools

# Disable NetworkManager for wlan0 management
sudo nmcli connection modify "UniFi" ipv4.method manual ipv4.addresses 192.168.0.211/24 ipv4.gateway 192.168.0.1 ipv4.dns "192.168.0.200 8.8.8.8"
sudo nmcli connection down "UniFi"
sudo nmcli connection up "UniFi"

# Create or modify the /etc/network/interfaces file for bat0
cat <<EOT | sudo tee /etc/network/interfaces
# Loopback network interface
auto lo
iface lo inet loopback

# bat0 configuration - static IP
auto bat0
iface bat0 inet static
    address 192.168.0.221
    netmask 255.255.255.0
    gateway 192.168.0.1

# Mesh configuration for BATMAN-adv
pre-up /sbin/modprobe batman-adv
pre-up /sbin/ip link set dev wlan0 down
pre-up /usr/sbin/batctl if add wlan0
pre-up /sbin/ip link set dev wlan0 up
pre-up /sbin/ip link set up dev bat0
EOT

# Enable BATMAN-adv module on boot
echo 'batman-adv' | sudo tee -a /etc/modules

# Restart networking services to apply changes
sudo systemctl restart networking

# Print status of interfaces
echo "Configuration complete. Interface statuses:"
ip a show wlan0
ip a show bat0
