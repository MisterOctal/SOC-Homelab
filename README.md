# Azure Cloud SOC Lab
**Status:** Active | **Author:** MisterOctal

## 🎯 Project Overview
This lab demonstrates the deployment of a scalable security monitoring environment in Microsoft Azure. It utilizes vulnerable "Honeypots" to attract global internet noise, which is then refined and analyzed through a multi-tier SIEM/SOAR pipeline.

The project highlights the transition from traditional on-premise monitoring to a cost-effective, cloud infrastructure.

## 🏗️ Technical Architecture
![test](https://lh3.googleusercontent.com/pw/AP1GczODnNbTipT3V8lBsiTqC8Va8rgfgxw1kzF2E8hu31aaDiH2GY078EIblCXtLomDydIEx26btVD4GsFe4-o-jxtkM-VXU1bPWfZRH-6PVmnS2RZoq9YgsGqtBlAAANx_jcoCtqjVlKvoupgEPurxxQB6=w1021-h752-s-no-gm?authuser=0)
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
