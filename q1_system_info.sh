#!/bin/bash
# This script displays system information
# Author: Your Name
# Date: $(date)
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
# Color codes
GREEN="\e[32m"
BLUE="\e[34m"
YELLOW="\e[33m"
CYAN="\e[36m"
RESET="\e[0m"

