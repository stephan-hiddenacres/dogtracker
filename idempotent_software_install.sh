#!/bin/bash

# Function to check if a package is installed
is_installed() {
    dpkg -l "$1" &> /dev/null
}

# Update package list
sudo apt update

# Install BATMAN-adv and related tools
if ! is_installed "batctl"; then
    echo "Installing BATMAN-adv and tools..."
    sudo apt install -y batctl wireless-tools
else
    echo "BATMAN-adv is already installed."
fi

# Install InfluxDB
if ! is_installed "influxdb"; then
    echo "Installing InfluxDB..."
    curl -sL https://repos.influxdata.com/influxdb.key | sudo apt-key add -
    echo "deb https://repos.influxdata.com/debian bookworm stable" | sudo tee /etc/apt/sources.list.d/influxdb.list
    sudo apt update && sudo apt install -y influxdb
    sudo systemctl enable influxdb
    sudo systemctl start influxdb
else
    echo "InfluxDB is already installed."
fi

# Install Node-RED
if ! is_installed "nodered"; then
    echo "Installing Node-RED..."
    sudo apt install -y nodejs npm
    sudo npm install -g --unsafe-perm node-red
    sudo systemctl enable nodered
    sudo systemctl start nodered
else
    echo "Node-RED is already installed."
fi

# Install Prometheus
if ! is_installed "prometheus"; then
    echo "Installing Prometheus..."
    sudo apt install -y prometheus
    sudo systemctl enable prometheus
    sudo systemctl start prometheus
else
    echo "Prometheus is already installed."
fi

# Install Grafana
if ! is_installed "grafana"; then
    echo "Installing Grafana..."
    sudo apt install -y software-properties-comm
