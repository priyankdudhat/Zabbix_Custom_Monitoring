# --- Oracle environment ---
$env:ORACLE_HOME="C:\oracle\product\19\dbhome_1"
$env:PATH="$env:ORACLE_HOME\bin;$env:PATH"

# --- SQL query ---
$sql = @"
SET HEADING OFF
SET FEEDBACK OFF
SET PAGESIZE 0
SET VERIFY OFF

SELECT CASE
  WHEN status = 'RUNNING' THEN 1
  WHEN status = 'COMPLETED' THEN 2
  WHEN status = 'RUNNING WITH WARNINGS' THEN 3
  WHEN status = 'COMPLETED WITH WARNINGS' THEN 4
  WHEN status = 'RUNNING WITH ERRORS' THEN 5
  WHEN status = 'COMPLETED WITH ERRORS' THEN 6
  WHEN status = 'FAILED' THEN 7
  ELSE 0
END
FROM v`$rman_backup_job_details
WHERE start_time = (
  SELECT MAX(start_time)
  FROM v`$rman_backup_job_details
);
EXIT
"@

# --- Execute SQL ---
$sql | sqlplus -s user_name/user_password | ForEach-Object { [int]$_.Trim() }

