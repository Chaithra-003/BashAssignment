#!/bin/bash

# Automated Backup Script
# Creates simple or compressed backups with timestamp
# Author: Your Name
BLUE="\e[34m"
GREEN="\e[32m"
RED="\e[31m"
YELLOW="\e[33m"
RESET="\e[0m"
echo -e "${BLUE}╔══════════════════════════════════════╗${RESET}"
echo -e "${BLUE}║${GREEN}         AUTOMATED BACKUP SCRIPT      ${BLUE}║${RESET}"
echo -e "${BLUE}╚══════════════════════════════════════╝${RESET}"
read -p "Enter directory to backup: " SOURCE
read -p "Enter backup destination: " DEST
if [ ! -d "$SOURCE" ]; then
    echo -e "${RED}Source directory does not exist!${RESET}"
    exit 1
fi
mkdir -p "$DEST"
echo "Select Backup Type:"
echo "1. Simple Copy"
echo "2. Compressed Archive (tar.gz)"
read -p "Enter choice: " TYPE
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
START=$(date +%s)
if [ "$TYPE" -eq 1 ]; then

    BACKUP_NAME="backup_$TIMESTAMP"
    cp -r "$SOURCE" "$DEST/$BACKUP_NAME"

elif [ "$TYPE" -eq 2 ]; then

    BACKUP_NAME="backup_$TIMESTAMP.tar.gz"
    tar -czf "$DEST/$BACKUP_NAME" -C "$(dirname "$SOURCE")" "$(basename "$SOURCE")"

else
    echo -e "${RED}Invalid choice!${RESET}"
    exit 1
fi
END=$(date +%s)
DURATION=$((END - START))

if [ -e "$DEST/$BACKUP_NAME" ]; then
    SIZE=$(du -sh "$DEST/$BACKUP_NAME" | awk '{print $1}')

    echo -e "\n${GREEN}Backup completed successfully!${RESET}"
    echo "----------------------------------------"
    echo "Backup File : $BACKUP_NAME"
    echo "Location    : $DEST"
    echo "Size        : $SIZE"
    echo "Time Taken  : $DURATION seconds"
else
    echo -e "${RED}Backup failed!${RESET}"
fi
# ===== Backup Rotation (Keep Last 5 Backups) =====

echo -e "\n${YELLOW}Checking old backups...${RESET}"
BACKUP_FILES=$(ls -t "$DEST"/backup_* 2>/dev/null | grep backup_)

COUNT=$(echo "$BACKUP_FILES" | wc -l)

if [ "$COUNT" -gt 5 ]; then

    REMOVE=$(echo "$BACKUP_FILES" | tail -n +6)

    echo "$REMOVE" | while read oldfile
    do
        rm -rf "$oldfile"
        echo -e "${RED}Deleted old backup: $oldfile${RESET}"
    done

else
    echo -e "${GREEN}No old backups to delete.${RESET}"
fi
