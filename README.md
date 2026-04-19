# Azure Cloud SOC Lab
**Status:** Active | **Author:** MisterOctal

## 🎯 Project Overview
This lab demonstrates the deployment of a scalable security monitoring environment in Microsoft Azure. It utilizes vulnerable "Honeypots" to attract global internet noise, which is then refined and analyzed through a multi-tier SIEM/SOAR pipeline.

The project highlights the transition from traditional on-premise monitoring to a cost-effective, cloud infrastructure.

## 🏗️ Technical Architecture
![test](https://cdn.discordapp.com/attachments/771248078652309515/1495349040001323038/azure_soc_lab.drawio_2.png?ex=69e5ebd1&is=69e49a51&hm=c7df11d1830eaa968b2825c79f93062382eae1152d185aab0ac58321523f5bfe)
- **Target Zone:** Windows and Linux Honeypots (Sysmon, Cowrie) exposed to the public internet to gather telemetry.
- **Analysis Zone:** A centralized ELK Stack (Elasticsearch, Logstash, Kibana) running on Ubuntu.
  - **Containerization:** Uptime Kuma deployed via Docker for real-time heartbeat monitoring of lab services.
- **SIEM/SOAR Zone:** Microsoft Sentinel integration for advanced KQL threat hunting and incident response automation.
- **Management Zone:** Dedicated zone for secure management of internal assets.

## 🛡️ Key Features
- **Cost-Efficient Ingestion:** Uses ELK as a "noise filter" to reduce Microsoft Sentinel ingestion costs.
- **GeoIP Mapping:** Visualizes attacker origins in real-time using Logstash enrichment.
- **Automated Response:** Employs Azure Logic Apps (SOAR) to respond to high-fidelity alerts.
- **Availability Monitoring:** Monitoring via containerized Uptime Kuma.
