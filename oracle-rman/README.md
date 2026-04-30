# Oracle RMAN Backup Monitoring using Zabbix Agent 2 (Windows)

## Overview

This document describes the complete configuration of **Oracle RMAN Backup monitoring** on a **Windows Oracle server** using **Zabbix Agent 2** and **PowerShell**.

The solution provides deep custom monitoring with:
- Secure, agent-based data collection
- Clean Green / Yellow / Red alerting behavior
- Value mapping and trigger-based logic
- Gauge-based dashboard visualization
- Reusable Zabbix template design

---

## Environment

- **Oracle Server:** LA-ORA-01
- **Operating System:** Windows
- **Database:** Oracle (RMAN)
- **Zabbix Version:** 7.0 LTS
- **Monitoring Method:** Zabbix Agent 2 + PowerShell

---

## 1. Oracle RMAN Backup Service Configuration (Server Side)

### 1. Oracle Read-Only Monitoring User

Create a read-only Oracle user with SELECT access to RMAN views.

Example user:
- **User:** TOAD (read-only)

The user must have SELECT permission on:

---

### 2. Create Script Directory

Create a directory on the Oracle server to store Zabbix custom scripts:

---

### 3. Create PowerShell Script

Create the PowerShell script:

Script requirements:
- Adjust `ORACLE_HOME` according to your Oracle installation
- Adjust `ORCL` if your Oracle service name is different
- Script must return **only a numeric value (0–7)**

The script evaluates the latest RMAN backup job and maps its status to a numeric code.

---

### 4. Test Script Manually

Before integrating with Zabbix, test the script manually on the Oracle server:

```powershell
powershell -ExecutionPolicy Bypass -File C:\Scripts\Zabbix_Rman_Sql\check_rman_status.ps1
