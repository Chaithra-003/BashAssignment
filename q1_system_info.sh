#!/bin/bash
# q1_system_info.sh
# Displays system information with color and saves to a file
# Author: Chaithra M
# Date: 24/02/2024

# Colors for terminal output
BLUE="\e[34m"
CYAN="\e[36m"
GREEN="\e[32m"
YELLOW="\e[33m"
RESET="\e[0m"

# Output file
output="system_info_report.txt"

# Gather system information
USERNAME=$(whoami)
HOSTNAME=$(hostname)
DATE_TIME=$(date "+%Y-%m-%d %H:%M:%S")
OS=$(uname -s)
CURRENT_DIR=$(pwd)
HOME_DIR=$HOME
USERS_ONLINE=$(who | wc -l)
UPTIME=$(uptime -p)
DISK_USAGE=$(df -h / | awk 'NR==2 {print $3 " used out of " $2 " (" $5 ")"}')
MEMORY_USAGE=$(free -h | awk '/Mem:/ {print $3 " used out of " $2}')

# Save to output file
{
echo "==== SYSTEM INFORMATION ===="
echo "Username      : $USERNAME"
echo "Hostname      : $HOSTNAME"
echo "Date & Time   : $DATE_TIME"
echo "OS            : $OS"
echo "Current Dir   : $CURRENT_DIR"
echo "Home Dir      : $HOME_DIR"
echo "Users Online  : $USERS_ONLINE"
echo "Uptime        : $UPTIME"
echo "Disk Usage    : $DISK_USAGE"
echo "Memory Usage  : $MEMORY_USAGE"
echo "============================"
} > "$output"

# Display nicely in terminal with colors
echo -e "${BLUE}==============================================${RESET}"
echo -e "${CYAN}        SYSTEM INFORMATION DISPLAY${RESET}"
echo -e "${BLUE}==============================================${RESET}"

echo -e "${GREEN}Username      :${RESET} $USERNAME"
echo -e "${GREEN}Hostname      :${RESET} $HOSTNAME"
echo -e "${GREEN}Date & Time   :${RESET} $DATE_TIME"
echo -e "${GREEN}OS            :${RESET} $OS"
echo -e "${GREEN}Current Dir   :${RESET} $CURRENT_DIR"
echo -e "${GREEN}Home Dir      :${RESET} $HOME_DIR"
echo -e "${GREEN}Users Online  :${RESET} $USERS_ONLINE"
echo -e "${GREEN}Uptime        :${RESET} $UPTIME"

echo -e "${YELLOW}Disk Usage    :${RESET} $DISK_USAGE"
echo -e "${YELLOW}Memory Usage  :${RESET} $MEMORY_USAGE"

echo -e "${BLUE}==============================================${RESET}"
echo "System information saved to $output"
