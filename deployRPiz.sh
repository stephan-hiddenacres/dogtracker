#!/bin/bash

# Update and upgrade system
sudo apt update && sudo apt upgrade -y

# Install dependencies for general tools
sudo apt install -y build-essential git curl

# Install bpytop using apt
sudo apt install bpytop -y

# Install Node-RED
sudo apt install -y nodejs npm
sudo npm install -g --unsafe-perm node-red
sudo systemctl enable nodered.service

# Install Prometheus
sudo apt install prometheus -y
sudo systemctl enable prometheus.service

# Install Grafana
sudo apt-get install -y software-properties-common
sudo add-apt-repository "deb https://packages.grafana.com/oss/deb stable main"
wget -q -O - https://packages.grafana.com/gpg.key | sudo apt-key add -
sudo apt-get update
sudo apt-get install -y grafana
sudo systemctl enable grafana-server

# Install InfluxDB
wget -qO- https://repos.influxdata.com/influxdb.key | sudo apt-key add -
source /etc/os-release
echo "deb https://repos.influxdata.com/debian $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/influxdb.list
sudo apt update && sudo apt install -y influxdb
sudo systemctl enable influxdb

# Install MQTT (Mosquitto)
sudo apt install -y mosquitto mosquitto-clients
sudo systemctl enable mosquitto

# Install Bluetooth Tools
sudo apt install -y bluez bluez-tools bluetooth pi-bluetooth

# Install BATMAN mesh networking support
sudo apt install -y batctl
sudo modprobe batman-adv
echo 'batman-adv' | sudo tee -a /etc/modules

# Enable BATMAN network interfaces
sudo ip link set dev wlan0 down
sudo batctl if add wlan0
sudo ip link set dev wlan0 up
sudo ip link set up dev bat0

# Enable services to start at boot
sudo systemctl enable nodered
sudo systemctl enable grafana-server
sudo systemctl enable prometheus
sudo systemctl enable influxdb
sudo systemctl enable mosquitto

# Reboot to apply all changes
sudo reboot
