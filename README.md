#  Bash Scripting Assignment – System Administration Toolkit

##  Overview

This repository contains 5 Bash scripts developed on Ubuntu Linux for system administration and cybersecurity tasks.

All scripts are compatible with:
- Ubuntu / Debian
- WSL (Windows Subsystem for Linux)

---

##  Scripts Included

### 1️)q1_system_info.sh
Displays detailed system information:
- OS details
- Kernel version
- CPU information
- Memory usage
- Disk usage
- System uptime
- ANSI color formatted output

---

### 2) q2_file_manager.sh
Menu-driven file and directory manager:
- Create file
- Delete file
- Rename file
- Create directory
- Delete directory
- List contents
- Input validation included

Run:
./q2_file_manager.sh

---

### 3️) q3_log_analyzer.sh
Log file analyzer with statistics:
- Total log entries
- Unique IP addresses
- Status code summary
- Most accessed page
- Top 3 IP addresses
- Suspicious activity detection (403 errors)
- Date range analysis

Run:
./q3_log_analyzer.sh access.log

---

### 4️) q4_backup.sh
Automated backup script:
- Simple copy backup
- Compressed tar.gz backup
- Timestamp naming
- Backup size display
- Execution time calculation
- Automatic backup rotation (keeps last 5 backups)

Run:
./q4_backup.sh

---

### 5️) q5_user_report.sh
User account reporting and security audit:
- User statistics
- Regular user table
- Group listing and member count
- Root privilege detection
- Users without passwords
- Inactive users
- Password expiry info
- Dangerous shell detection
- /bin/false account detection
- Auto text report saving
- HTML report export

Run:
sudo ./q5_user_report.sh

---

## Requirements

- Ubuntu / Debian Linux
- Bash Shell
- sudo privileges (for security checks)

---

##  How to Run All Scripts

Make scripts executable:

chmod +x *.sh

Example execution:

./q1_system_info.sh
./q2_file_manager.sh
./q3_log_analyzer.sh access.log
./q4_backup.sh
sudo ./q5_user_report.sh

---

## Concepts Used

- awk
- grep
- cut
- sort
- uniq
- wc
- tar
- date
- chage
- lastlog
- file permissions
- conditional statements
- loops
- formatted output

---

##  Learning Outcome

This project demonstrates:

- Linux system administration skills
- Log analysis techniques
- Backup automation
- Security auditing basics
- File system management
- Real-world Bash scripting practices

---

##  Author

Chaithra M 
1SG22CS020,
Cybersecurity Student, 
Ubuntu Linux Environment.
