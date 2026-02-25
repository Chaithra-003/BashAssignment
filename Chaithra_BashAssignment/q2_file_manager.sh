#!/bin/bash

# File & Directory Manager
# Provides menu-based file operations
# Author: Your Name
BLUE="\e[34m"
GREEN="\e[32m"
RED="\e[31m"
YELLOW="\e[33m"
RESET="\e[0m"
while true
do
echo -e "${BLUE}╔══════════════════════════════════════╗${RESET}"
echo -e "${BLUE}║${GREEN}        FILE & DIRECTORY MANAGER     ${BLUE}║${RESET}"
echo -e "${BLUE}╠══════════════════════════════════════╣${RESET}"
echo -e "${BLUE}║ 1. List files                       ║${RESET}"
echo -e "${BLUE}║ 2. Create new directory             ║${RESET}"
echo -e "${BLUE}║ 3. Create new file                  ║${RESET}"
echo -e "${BLUE}║ 4. Delete a file                    ║${RESET}"
echo -e "${BLUE}║ 5. Rename a file                    ║${RESET}"
echo -e "${BLUE}║ 6. Search for a file                ║${RESET}"
echo -e "${BLUE}║ 7. Count files & directories        ║${RESET}"
echo -e "${BLUE}║ 8. View file permissions            ║${RESET}"
echo -e "${BLUE}║ 9. Copy a file                      ║${RESET}"
echo -e "${BLUE}║10. Exit                             ║${RESET}"
echo -e "${BLUE}╚══════════════════════════════════════╝${RESET}"
read -p "Enter your choice: " choice
case $choice in
1)
    ls -lh
    ;;
2)
    read -p "Enter directory name: " dirname
    if [ -d "$dirname" ]; then
        echo -e "${RED}Directory already exists!${RESET}"
    else
        mkdir "$dirname"
        echo -e "${GREEN}Directory created successfully.${RESET}"
    fi
    ;;
3)
    read -p "Enter file name: " filename
    if [ -f "$filename" ]; then
        echo -e "${RED}File already exists!${RESET}"
    else
        touch "$filename"
        echo -e "${GREEN}File created successfully.${RESET}"
    fi
    ;;
4)
    read -p "Enter file name to delete: " filename
    if [ -f "$filename" ]; then
        rm -i "$filename"
        echo -e "${YELLOW}File deleted.${RESET}"
    else
        echo -e "${RED}File not found!${RESET}"
    fi
    ;;
5)
    read -p "Enter old file name: " oldname
    read -p "Enter new file name: " newname
    if [ -f "$oldname" ]; then
        mv "$oldname" "$newname"
        echo -e "${GREEN}File renamed successfully.${RESET}"
    else
        echo -e "${RED}File not found!${RESET}"
    fi
    ;;
6)
    read -p "Enter file name or pattern to search: " pattern
    find . -name "$pattern"
    ;;
7)
    files=$(find . -type f | wc -l)
    dirs=$(find . -type d | wc -l)
    echo -e "${GREEN}Total Files: $files${RESET}"
    echo -e "${GREEN}Total Directories: $dirs${RESET}"
    ;;
10)
    echo "Exiting..."
    break
    ;;
8)
    read -p "Enter file name: " filename
    if [ -e "$filename" ]; then
        ls -l "$filename"
    else
        echo -e "${RED}File not found!${RESET}"
    fi
    ;;
9)
    read -p "Enter source file name: " source
    read -p "Enter destination file name: " dest
    if [ -f "$source" ]; then
        cp "$source" "$dest"
        echo -e "${GREEN}File copied successfully.${RESET}"
    else
        echo -e "${RED}Source file not found!${RESET}"
    fi
    ;;
*)
    echo -e "${RED}Invalid choice! Please select 1-11.${RESET}"
    ;;
esac
done
