# Octal's SOC Homelab: Offensive & Defensive Environment
> **Status:** Active  
> **Phase:** Phase 1 - The "Tug of War"  
> **Documentation:** [Gitbook](https://misteroctal.gitbook.io/octal-lab)

## 1. Project Goals
The primary goal of this lab is to gain hands-on SOC experience and bridge the gap between academic study and professional application. This environment serves as a living portfolio piece to demonstrate proficiency in building, attacking, defending, and monitoring networked systems.

## 2. Architecture & Environment
The lab is fully virtualized and locally hosted, ensuring a contained environment for security testing.

### Virtualization Layer
* **Hypervisor:** VMware Workstation Pro (Chosen for industry alignment and academic consistency).
* **Networking:** **Strict Host-Only configuration.** This creates a "sandbox" that prevents malicious traffic from interacting with the physical LAN or the public internet.

### Current Virtual Machines
| Role | OS / Image | Purpose |
| :--- | :--- | :--- |
| **Attacker** | Kali Linux | Penetration testing, exploit and script development. |
| **Target** | Metasploitable 2 | Vulnerable Linux target for exploitation and mitigation practice. |

## 3. Roadmap & Evolution
This lab follows a phased approach, evolving as my skills in cybersecurity expand.

* **Phase 1: The "Tug of War" (Current)** A continuous cycle of attack and defense. I exploit a vulnerability, analyze the logs/artifacts, patch the target, and then verify the fix by re-testing the attack.
* **Phase 2: Modern Escalation** Transitioning to Metasploitable 3 to tackle more modern vulnerabilities and complex Windows/Linux configurations.
* **Phase 3: Centralized Monitoring (SIEM)** Deployment of a SIEM (e.g., ELK or Splunk) to shift focus toward log aggregation, real-time alerting, and proactive threat hunting.
