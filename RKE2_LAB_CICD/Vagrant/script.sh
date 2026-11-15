#!/bin/bash

# Echo the hostname
echo "Hostname: $(hostname)"

# Echo the IP address
echo "IP address: $(hostname -I)"

# Echo the uptime
echo "Uptime: $(uptime)"

# Echo the disk space
echo "Disk space: $(df -h)"

# Install sshpass (required for Ansible password-based SSH authentication)
sudo apt-get update -y
sudo apt-get install -y sshpass