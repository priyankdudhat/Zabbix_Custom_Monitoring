RMAN Backup Service Configuration (LA-ORA-01):

1). Oracle Read only user: Toad
2). Create script directory: C:\Scripts\Zabbix_Rman_Sql
3). Create PowerShell Script:
	- Adjust ORACLE_HOME
	- Adjust ORCL if your service name is different
	- store it at script directory: C:\Scripts\Zabbix_Rman_Sql\check_rman_status.ps1
4). Testing Script Manually:
	- powershell -ExecutionPolicy Bypass -File C:\Scripts\Zabbix_Rman_Sql\check_rman_status.ps1
5). Install & Configure zabbix agent 2
	- Download and Install Zabbix Win Agent2 7.0 LTS
	- Configue installation by setting HOST_NAME (should be same as Zabbix UI has)and SERVER_IP AND PROXY_SERVER_IP (both should be 	  same if not Hist is not monitored by Proxy server)
	- Edit Conf file (C:\Program Files\Zabbix Agent 2\zabbix_agent2.conf)
	  Add parameter at bottom:
	  UserParameter=oracle.rman.status,powershell -ExecutionPolicy Bypass -File C:\Scripts\Zabbix_Rman_Sql\check_rman_status.ps1
	- Restart zabbix agent: restart zabbix-agent2
6). Zabbix UI:
	- Create New Template:
		Name: LA - ORA RMAN Backup Status Windows by Zabbix Agent 2
		Template Group: LA - Windows
		Tags: application-oracle, backup-rman, component-rman, value-status
		Value Mapping:
			Name: Oracle RMAN Backup Status
			Mappings: 0 - Unknown
				  1 - Running
			          2 - Completed
				  3 - Running with Warnings
				  4 - Completed with Warnings
				  5 - Running with Errors
				  6 - Completed with Errors
				  7 - Failed
	- Create Item in Template:
		Name: RMAN Backup Status SCPROD
		Type: Zabbix Agent
		Key: oracle.rman.status (NOTE: should be same as UserParameter in Zabbix Agent Config file has)
		Type of information: Numeric (unsigned)
		Update Interval. 15m
		History: 7d
		Trends: 365d
		Value Mapping: Select what we have created at template level - ORACLE RMAN Backup Status
		Enable: Checked
	- Create Triggers:
		1). Warning: Oracle RMAN Backup finished with warnings or unknown
		    Operational Data: Current state: {ITEM.LASTVALUE1}
		    Expression: (HINT: (0 or (3 and 4)))
		    last(/LA - ORA RMAN Backup Status Windows by Zabbix Agent 2/oracle.rman.status)=0
		    or
                    (last(/LA - ORA RMAN Backup Status Windows by Zabbix Agent 2/oracle.rman.status)>=3 and last(/LA - ORA RMAN Backup Status                	            Windows by Zabbix Agent 2/oracle.rman.status)<=4)
		2). High: Oracle RMAN Backup failed or has errors
		    Operational Data: Current state: {ITEM.LASTVALUE1}
		    Expression: (HINT: eqal to 5 or more than 5)
		    last(/LA - ORA RMAN Backup Status Windows by Zabbix Agent 2/oracle.rman.status)>=5
		    Recovery Expression:
		    last(/LA - ORA RMAN Backup Status Windows by Zabbix Agent 2/oracle.rman.status)=1
		    or
 		    last(/LA - ORA RMAN Backup Status Windows by Zabbix Agent 2/oracle.rman.status)=2
	- Create Dashbaord:
		Create Widget: Gauge Map
		Select
