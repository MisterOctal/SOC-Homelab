#!/bin/bash
# Basic VM Initialization Script

# Ensure the script is running as root
if [ "$EUID" -ne 0 ]; then
  echo "Error: Please run this script as root or using sudo." >&2
  exit 1
fi

# Redirect output to a log file and terminal
exec > >(tee -a /var/log/vm-init.log) 2>&1
echo "Starting VM Initialization..."

# Suppress interactive prompts
export DEBIAN_FRONTEND=noninteractive

echo "Updating package lists..."
apt-get update -y

echo "Upgrading system packages..."
apt-get dist-upgrade -y

echo "Installing common troubleshooting tools..."
apt-get install -y curl wget iproute2 unzip nano htop ufw git build-essential

echo "Configuring basic firewall safety..."
ufw default deny incoming
ufw default allow outgoing
ufw allow ssh
ufw --force enable

echo "Cleaning up package cache..."
apt-get autoremove -y
apt-get clean

echo "Initialization Complete!