#!/bin/bash
# Create an override file that forces Port 64295
echo "Port 64295" | sudo tee /etc/ssh/sshd_config.d/99-custom-port.conf

# Completely kill the Ubuntu socket activation
sudo systemctl stop ssh.socket
sudo systemctl disable ssh.socket
sudo systemctl daemon-reload

# Ensure local firewall is open for the new port
sudo ufw allow 64295/tcp

# Restart the traditional SSH service
sudo systemctl restart ssh

# Show exactly what ports SSH is listening on now
sudo ss -tulpn | grep ssh