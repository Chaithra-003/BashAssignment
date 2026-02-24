#!/bin/bash
# Log File Analyzer Script
# Analyzes web server log and generates statistics
# ===== Color Codes =====
BLUE="\e[34m"
GREEN="\e[32m"
RED="\e[31m"
YELLOW="\e[33m"
RESET="\e[0m"

# ===== Argument Check =====
if [ $# -ne 1 ]; then
    echo -e "${RED}Usage: $0 <logfile>${RESET}"
    exit 1
fi

LOGFILE=$1

# ===== File Validation =====
if [ ! -f "$LOGFILE" ]; then
    echo -e "${RED}Error: File not found!${RESET}"
    exit 1
fi

if [ ! -s "$LOGFILE" ]; then
    echo -e "${YELLOW}Log file is empty.${RESET}"
    exit 1
fi

# ===== Header =====
echo -e "${BLUE}╔══════════════════════════════════════════╗${RESET}"
echo -e "${BLUE}║${GREEN}           LOG FILE ANALYSIS              ${BLUE}║${RESET}"
echo -e "${BLUE}╚══════════════════════════════════════════╝${RESET}"

# ===== Total Entries =====
TOTAL=$(wc -l < "$LOGFILE")
echo -e "\n${GREEN}Total Entries:${RESET} $TOTAL"

# ===== Unique IP Addresses =====
echo -e "\n${GREEN}Unique IP Addresses:${RESET}"
awk '{print $1}' "$LOGFILE" | sort | uniq

IP_COUNT=$(awk '{print $1}' "$LOGFILE" | sort | uniq | wc -l)
echo -e "Total Unique IPs: $IP_COUNT"

# ===== Status Code Summary =====
echo -e "\n${GREEN}Status Code Summary:${RESET}"
awk '{print $NF}' "$LOGFILE" | sort | uniq -c | while read count code
do
    echo "  $code : $count requests"
done

# ===== Most Accessed Page =====
MOST_PAGE=$(awk -F\" '{print $2}' "$LOGFILE" | awk '{print $2}' | sort | uniq -c | sort -nr | head -1)

echo -e "\n${GREEN}Most Accessed Page:${RESET}"
echo "$MOST_PAGE"

# ===== Top 3 IP Addresses =====
echo -e "\n${GREEN}Top 3 IP Addresses:${RESET}"
awk '{print $1}' "$LOGFILE" | sort | uniq -c | sort -nr | head -3 | while read count ip
do
    echo "  $ip - $count requests"
done

# ===== Security Threat Detection =====
echo -e "\n${YELLOW}Security Threat Detection:${RESET}"

SUSPICIOUS_IPS=$(awk '$NF == 403 {print $1}' "$LOGFILE" | sort | uniq -c | awk '$1 > 2')

if [ -z "$SUSPICIOUS_IPS" ]; then
    echo -e "${GREEN}No suspicious activity detected.${RESET}"
else
    echo "$SUSPICIOUS_IPS" | while read count ip
    do
        echo -e "${RED}⚠ Suspicious IP: $ip ($count forbidden requests)${RESET}"
    done
fi


# ===== Date Range Analysis=====
echo -e "\n${GREEN}Date Range Analysis:${RESET}"

FIRST_DATE=$(awk -F'[][]' '{print $2}' "$LOGFILE" | head -1)
LAST_DATE=$(awk -F'[][]' '{print $2}' "$LOGFILE" | tail -1)

echo "  First Log Entry : $FIRST_DATE"
echo "  Last Log Entry  : $LAST_DATE"
