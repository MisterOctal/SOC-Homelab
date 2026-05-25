#!/usr/bin/env python3
import os
import random
import string
import hashlib
from datetime import datetime, timedelta

# Configuration
HONEYFS_BASE = os.path.expanduser("~/cowrie/honeyfs")
HOSTNAME = "db-prod-01"
OS_VERSION = "Ubuntu 22.04.2 LTS"

# Define fake targets with specific roles
FAKE_USERS = [
    {"user": "dbadmin", "uid": 1001, "gid": 1001, "desc": "Database Administrator", "shell": "/bin/bash", "role": "db"},
    {"user": "webmaster", "uid": 1002, "gid": 1002, "desc": "Web Application Manager", "shell": "/bin/bash", "role": "web"},
    {"user": "josem", "uid": 1003, "gid": 1003, "desc": "Jose Manuel Miranda", "shell": "/bin/bash", "role": "support"},
    {"user": "jenkins", "uid": 1004, "gid": 1004, "desc": "Jenkins CI/CD", "shell": "/bin/bash", "role": "ci"}
]

# Generate realistic random IP addresses
def random_ip():
    return f"{random.randint(11, 254)}.{random.randint(0, 255)}.{random.randint(0, 255)}.{random.randint(1, 254)}"

# Generate fake SHA-512 crypt hashes for /etc/shadow
def fake_hash():
    salt = ''.join(random.choices(string.ascii_letters + string.digits, k=8))
    fake_hash_body = ''.join(random.choices(string.ascii_letters + string.digits + "./", k=86))
    return f"$6${salt}${fake_hash_body}"

# Create the directory skeleton
def create_directories():
    directories = [
        f"{HONEYFS_BASE}/var/log/nginx",
        f"{HONEYFS_BASE}/var/log/mysql",
        f"{HONEYFS_BASE}/root/.ssh",
        f"{HONEYFS_BASE}/root/.aws",
        f"{HONEYFS_BASE}/etc/ssh",
        f"{HONEYFS_BASE}/etc/cron.d",
        f"{HONEYFS_BASE}/var/www/html/config",
        f"{HONEYFS_BASE}/var/backups",
        f"{HONEYFS_BASE}/tmp"
    ]
    for u in FAKE_USERS:
        directories.append(f"{HONEYFS_BASE}/home/{u['user']}/.ssh")
    
    for d in directories:
        os.makedirs(d, exist_ok=True)

# 1. Generate Core System Identity Files
def generate_system_files():
    # /etc/os-release
    os_release = f"""PRETTY_NAME="{OS_VERSION}"
NAME="Ubuntu"
VERSION_ID="22.04"
VERSION="22.04.2 LTS (Jammy Jellyfish)"
VERSION_CODENAME=jammy
ID=ubuntu
ID_LIKE=debian
HOME_URL="https://www.ubuntu.com/"
SUPPORT_URL="https://help.ubuntu.com/"
BUG_REPORT_URL="https://bugs.launchpad.net/ubuntu/"
PRIVACY_POLICY_URL="https://www.ubuntu.com/legal/terms-and-policies/privacy-policy"
UBUNTU_CODENAME=jammy
"""
    with open(f"{HONEYFS_BASE}/etc/os-release", "w") as f: f.write(os_release)
    with open(f"{HONEYFS_BASE}/etc/issue", "w") as f: f.write(f"Ubuntu 22.04.2 LTS \\n \\l\n\n")
    with open(f"{HONEYFS_BASE}/etc/hostname", "w") as f: f.write(f"{HOSTNAME}\n")
    
    # /etc/hosts
    hosts = f"127.0.0.1 localhost\n127.0.1.1 {HOSTNAME}\n\n# The following lines are desirable for IPv6 capable hosts\n::1     ip6-localhost ip6-loopback\nff02::1 ip6-allnodes\nff02::2 ip6-allrouters\n"
    with open(f"{HONEYFS_BASE}/etc/hosts", "w") as f: f.write(hosts)

# 2. Generate Users, Passwords, and Groups
def generate_accounts():
    base_passwd = [
        "root:x:0:0:root:/root:/bin/bash",
        "daemon:x:1:1:daemon:/usr/sbin:/usr/sbin/nologin",
        "bin:x:2:2:bin:/bin:/usr/sbin/nologin",
        "sys:x:3:3:sys:/dev:/usr/sbin/nologin",
        "nobody:x:65534:65534:nobody:/nonexistent:/usr/sbin/nologin",
        "mysql:x:114:114:MySQL Server,,,:/nonexistent:/bin/false",
        "www-data:x:33:33:www-data:/var/www:/usr/sbin/nologin"
    ]
    base_shadow = [
        f"root:{fake_hash()}:19345:0:99999:7:::",
        "daemon:*:19345:0:99999:7:::",
        "bin:*:19345:0:99999:7:::",
        "sys:*:19345:0:99999:7:::",
        "nobody:*:19345:0:99999:7:::",
        "mysql:!:19345:0:99999:7:::",
        "www-data:*:19345:0:99999:7:::"
    ]
    
    for u in FAKE_USERS:
        base_passwd.append(f"{u['user']}:x:{u['uid']}:{u['gid']}:{u['desc']},,,:/home/{u['user']}:{u['shell']}")
        base_shadow.append(f"{u['user']}:{fake_hash()}:19345:0:99999:7:::")
        
    with open(f"{HONEYFS_BASE}/etc/passwd", "w") as f: f.write("\n".join(base_passwd) + "\n")
    with open(f"{HONEYFS_BASE}/etc/shadow", "w") as f: f.write("\n".join(base_shadow) + "\n")

# 3. Generate Tempting Lures (Keys, Configs, DBs)
def generate_lures():
    # Fake AWS Credentials for root
    aws_creds = """[default]
aws_access_key_id = AKIAIOSFODNN7EXAMPLE
aws_secret_access_key = wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY
region = us-east-1
"""
    with open(f"{HONEYFS_BASE}/root/.aws/credentials", "w") as f: f.write(aws_creds)

    # Fake SSH Private Key for Jenkins (High value target)
    fake_rsa = """-----BEGIN OPENSSH PRIVATE KEY-----
b3BlbnNzaC1rZXktdjEAAAAABG5vbmUAAAAEbm9uZQAAAAAAAAABAAABlwAAAAdzc2gtcn
NhAAAAAwEAAQAAAYEAwK1Q... [Fake Key Data Omitted for brevity, but attackers will try to copy it] ...
-----END OPENSSH PRIVATE KEY-----
"""
    with open(f"{HONEYFS_BASE}/home/jenkins/.ssh/id_rsa", "w") as f: f.write(fake_rsa)
    with open(f"{HONEYFS_BASE}/home/jenkins/.ssh/id_rsa.pub", "w") as f: f.write("ssh-rsa AAAAB3NzaC1... jenkins@build-server\n")

    # Fake DB configuration file in webroot
    wp_config = """<?php
define( 'DB_NAME', 'production_app' );
define( 'DB_USER', 'app_user' );
define( 'DB_PASSWORD', 'P@ssw0rd2023!_prod' );
define( 'DB_HOST', 'localhost' );
define( 'WP_DEBUG', false );
?>"""
    with open(f"{HONEYFS_BASE}/var/www/html/config/database.php", "w") as f: f.write(wp_config)
    
    # Fake SQL Dump Backup
    sql_dump = """-- MySQL dump 10.13
-- Host: localhost    Database: production_app
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
);
INSERT INTO `users` VALUES (1,'admin','$2y$10$QO8...'),(2,'ceo','$2y$10$Lp1...');
"""
    with open(f"{HONEYFS_BASE}/var/backups/db_backup_latest.sql", "w") as f: f.write(sql_dump)

# 4. Generate Bash Histories (Attackers ALWAYS check this)
def generate_histories():
    histories = {
        "root": ["apt update", "apt upgrade -y", "systemctl restart sshd", "tail -f /var/log/auth.log", "nano /etc/ssh/sshd_config", "docker ps"],
        "dbadmin": ["mysql -u root -p", "mysqldump -u root -p production_app > /var/backups/db_backup_latest.sql", "htop", "ping 8.8.8.8", "exit"],
        "webmaster": ["cd /var/www/html", "git pull origin main", "composer install", "sudo systemctl reload nginx", "cat config/database.php"],
        "jenkins": ["ssh webmaster@10.0.1.45 'deploy.sh'", "docker build -t app:latest .", "git clone git@github.com:company/private-repo.git"]
    }
    
    for user, commands in histories.items():
        home_dir = "/root" if user == "root" else f"/home/{user}"
        # Add some random standard commands
        full_history = ["ls -la", "pwd", "whoami"] + commands + ["clear", "exit"]
        with open(f"{HONEYFS_BASE}{home_dir}/.bash_history", "w") as f: 
            f.write("\n".join(full_history) + "\n")

# 5. Generate Realistic Logs
def generate_logs():
    now = datetime.now()
    auth_lines = []
    
    for i in range(30):
        ts = (now - timedelta(hours=random.randint(0, 48), minutes=random.randint(0, 59))).strftime("%b %d %H:%M:%S")
        ip = random_ip()
        
        # 80% failed logins (brute force simulation), 20% successful
        if random.random() > 0.2:
            user = random.choice(["root", "admin", "ubuntu", "test"])
            auth_lines.append(f"{ts} {HOSTNAME} sshd[{random.randint(1000, 9999)}]: Failed password for {user} from {ip} port {random.randint(30000, 60000)} ssh2")
        else:
            user = random.choice([u["user"] for u in FAKE_USERS])
            auth_lines.append(f"{ts} {HOSTNAME} sshd[{random.randint(1000, 9999)}]: Accepted password for {user} from 10.0.0.{random.randint(10, 50)} port {random.randint(30000, 60000)} ssh2")
            auth_lines.append(f"{ts} {HOSTNAME} sshd[{random.randint(1000, 9999)}]: pam_unix(sshd:session): session opened for user {user} by (uid=0)")
    
    auth_lines.sort() # Sort by timestamp
    with open(f"{HONEYFS_BASE}/var/log/auth.log", "w") as f: f.write("\n".join(auth_lines) + "\n")

# Execute all functions
if __name__ == "__main__":
    print(f"[*] Building enhanced HoneyFS structure in {HONEYFS_BASE}...")
    create_directories()
    generate_system_files()
    generate_accounts()
    generate_lures()
    generate_histories()
    generate_logs()
    print("[+] HoneyFS generation complete! Ready to deceive.")