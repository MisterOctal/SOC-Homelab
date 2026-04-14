# Azure Cloud SOC Lab
**Status:** Active | **Author:** MisterOctal

## 🎯 Project Overview
This lab demonstrates the deployment of a scalable security monitoring environment in Microsoft Azure. It utilizes vulnerable "Honeypots" to attract global internet noise, which is then refined and analyzed through a multi-tier SIEM/SOAR pipeline.

The project highlights the transition from traditional on-premise monitoring to a cost-effective, cloud infrastructure.

## 🏗️ Technical Architecture
![test](https://lh3.googleusercontent.com/pw/AP1GczOFwtj6_9c9DIZMwq92WlzCDffpW0bvZ4Omcd0rAZeu9eb44cb4IQG5nCe8m4L6azx8wYfe-7yPesLt83ANmfhvyucX4BQi4w8LKe8TjwfonATlC4YC4_U9Gpij7CZHNx91LT4UV3SEdoCzVTVH2mO3=w1180-h869-s-no-gm?authuser=0)
- **Target Zone:** Windows and Linux Honeypots (Sysmon, Cowrie) exposed to the public internet to gather telemetry.
- **Analysis Zone:** A centralized ELK Stack (Elasticsearch, Logstash, Kibana) running on Ubuntu.
  - **Containerization:** Uptime Kuma deployed via Docker for real-time heartbeat monitoring of lab services.
- **SIEM/SOAR Zone:** Microsoft Sentinel integration for advanced KQL threat hunting and incident response automation.
- **Management Zone:** Azure Bastion for secure, browser-based management of internal assets.

## 🛡️ Key Features
- **Cost-Efficient Ingestion:** Uses ELK as a "noise filter" to reduce Microsoft Sentinel ingestion costs.
- **GeoIP Mapping:** Visualizes attacker origins in real-time using Logstash enrichment.
- **Automated Response:** Employs Azure Logic Apps (SOAR) to respond to high-fidelity alerts.
- **Availability Monitoring:** Monitoring via containerized Uptime Kuma.
