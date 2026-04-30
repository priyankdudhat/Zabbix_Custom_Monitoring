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
