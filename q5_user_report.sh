#!/bin/bash
# USER ACCOUNT REPORTER WITH SECURITY CHECKS 
# COLORS 
BLUE="\e[34m"
GREEN="\e[32m"
RED="\e[31m"
YELLOW="\e[33m"
RESET="\e[0m"

#SAVE REPORT TO FILE
REPORT_FILE="user_report_$(date +%Y%m%d_%H%M%S).txt"
exec > >(tee -a "$REPORT_FILE")
exec 2>&1

#  HEADER
echo -e "${BLUE}╔══════════════════════════════════════════╗${RESET}"
echo -e "${BLUE}║${GREEN}        USER ACCOUNT REPORT               ${BLUE}║${RESET}"
echo -e "${BLUE}╚══════════════════════════════════════════╝${RESET}"


echo -e "\n${GREEN}=== USER STATISTICS ===${RESET}"

TOTAL_USERS=$(wc -l < /etc/passwd)
SYSTEM_USERS=$(awk -F: '$3 < 1000 {count++} END {print count+0}' /etc/passwd)
REGULAR_USERS=$(awk -F: '$3 >= 1000 {count++} END {print count+0}' /etc/passwd)
LOGGED_IN=$(who | awk '{print $1}' | sort -u | wc -l)

echo "Total Users              : $TOTAL_USERS"
echo "System Users (UID <1000) : $SYSTEM_USERS"
echo "Regular Users (UID>=1000): $REGULAR_USERS"
echo "Currently Logged In      : $LOGGED_IN"



echo -e "\n${GREEN}=== REGULAR USER DETAILS ===${RESET}"

printf "%-15s %-8s %-25s %-15s\n" "Username" "UID" "Home Directory" "Shell"
printf "%-15s %-8s %-25s %-15s\n" "--------" "---" "--------------" "-----"

awk -F: '$3 >= 1000 {printf "%-15s %-8s %-25s %-15s\n", $1, $3, $6, $7}' /etc/passwd
echo -e "\n${GREEN}=== GROUP INFORMATION ===${RESET}"

echo -e "\nAll Groups:"
awk -F: '{print $1}' /etc/group

echo -e "\nGroup Member Counts:"
awk -F: '{
    if ($4 == "")
        count = 0;
    else
        count = split($4, arr, ",");
    printf "%-20s %d members\n", $1, count
}' /etc/group
echo -e "\n${YELLOW}=== SECURITY CHECKS ===${RESET}"


echo -e "\nUsers with UID 0 (Root Privileges):"
awk -F: '$3 == 0 {print $1}' /etc/passwd


echo -e "\nUsers Without Passwords:"
NO_PASS=$(sudo awk -F: '($2 == "" || $2 == "!") {print $1}' /etc/shadow 2>/dev/null)

if [ -z "$NO_PASS" ]; then
    echo "All users have passwords set."
else
    echo "$NO_PASS"
fi


echo -e "\nInactive Users (Never Logged In):"
lastlog | awk 'NR>1 && $4 == "**Never" {print $1}'


echo -e "\nPassword Expiry Information:"
for user in $(awk -F: '$3 >= 1000 {print $1}' /etc/passwd)
do
    EXPIRY=$(sudo chage -l "$user" 2>/dev/null | grep "Password expires" | cut -d: -f2)
    echo "$user → $EXPIRY"
done


echo -e "\nUsers with Dangerous Shells (/bin/bash or /bin/sh):"
awk -F: '$7 ~ /\/bin\/bash|\/bin\/sh/ {print $1 " → " $7}' /etc/passwd


echo -e "\nService Accounts Using /bin/false:"
awk -F: '$7 == "/bin/false" {print $1}' /etc/passwd

HTML_FILE="user_report_$(date +%Y%m%d_%H%M%S).html"

echo "<html><body><h2>User Account Report</h2><pre>" > "$HTML_FILE"
cat "$REPORT_FILE" >> "$HTML_FILE"
echo "</pre></body></html>" >> "$HTML_FILE"

echo -e "\n${GREEN}Report saved to: $REPORT_FILE${RESET}"
echo -e "${GREEN}HTML report generated: $HTML_FILE${RESET}"
