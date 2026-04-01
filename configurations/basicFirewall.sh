#!/bin/bash

# ==============================================================================
# Basic Aggressive Firewall Script
# Description: Flushes existing rules and implements a "Deny by Default" 
# Whitelist policy allowing only SSH (22), HTTP (80), and HTTPS (443).
# ==============================================================================

# Ensure the script is run with root privileges
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root (use sudo)."
   exit 1
fi

echo "[*] Initializing Firewall Hardening..."

# ---------------------------------------------------------
# A. CLEAR EXISTING RULES (The Flush)
# ---------------------------------------------------------
echo "[+] Flushing existing iptables rules and chains..."
iptables -F          # Flush all chains
iptables -X          # Delete custom chains
iptables -Z          # Zero packet and byte counters
iptables -P INPUT ACCEPT  # Temporarily set policy to ACCEPT to prevent lockout

# ---------------------------------------------------------
# B. APPLY NEW WHITELIST
# ---------------------------------------------------------
echo "[+] Applying new whitelist policy..."

# 1. Allow established and related connections
# Note: Using '-m state' for compatibility with older kernels
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT

# 2. Allow Loopback (Localhost) interface
iptables -A INPUT -i lo -j ACCEPT

# 3. Allow Essential Services
echo "[+] Opening Port 22 (SSH)..."
iptables -A INPUT -p tcp --dport 22 -j ACCEPT

echo "[+] Opening Port 80 (HTTP)..."
iptables -A INPUT -p tcp --dport 80 -j ACCEPT

echo "[+] Opening Port 443 (HTTPS)..."
iptables -A INPUT -p tcp --dport 443 -j ACCEPT

# 4. DROP EVERYTHING ELSE
echo "[!] Setting default policies to DROP..."
iptables -P INPUT DROP
iptables -P FORWARD DROP

# ---------------------------------------------------------
# C. VERIFICATION
# ---------------------------------------------------------
echo ""
echo "[*] Hardening Complete. Current Status:"
iptables -L -n -v

echo ""
echo "[!] WARNING: If you lose access, reboot the VM to reset rules (unless saved)."