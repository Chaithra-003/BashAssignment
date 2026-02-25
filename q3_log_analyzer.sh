#!/bin/bash
# q3_log_analyzer.sh - Analyze log file statistics
# Author: Chaithra M
# Date: 24/02/2024
# Saves analysis to log_analysis_report.txt

# -------------------------------
# Output file
# -------------------------------
output="log_analysis_report.txt"

# -------------------------------
# Prompt user for log file
# -------------------------------
read -p "Enter path to the log file: " logfile

# Check if file exists
if [[ ! -f "$logfile" ]]; then
    echo "Error: File '$logfile' not found."
    exit 1
fi

# -------------------------------
# Gather log statistics
# -------------------------------
TOTAL_LINES=$(wc -l < "$logfile")
TOTAL_WORDS=$(wc -w < "$logfile")
TOTAL_CHARS=$(wc -m < "$logfile")
ERROR_LINES=$(grep -i "error" "$logfile" | wc -l)
WARNING_LINES=$(grep -i "warning" "$logfile" | wc -l)
INFO_LINES=$(grep -i "info" "$logfile" | wc -l)

# -------------------------------
# Write to output file
# -------------------------------
{
echo "=============================================="
echo "        LOG FILE ANALYSIS REPORT"
echo "File analyzed: $logfile"
echo "=============================================="
echo "Total Lines    : $TOTAL_LINES"
echo "Total Words    : $TOTAL_WORDS"
echo "Total Chars    : $TOTAL_CHARS"
echo "Error Lines    : $ERROR_LINES"
echo "Warning Lines  : $WARNING_LINES"
echo "Info Lines     : $INFO_LINES"
echo "=============================================="
} > "$output"

# -------------------------------
# Display report to terminal
# -------------------------------
echo "Log analysis report for '$logfile':"
echo "----------------------------------------------"
echo "Total Lines    : $TOTAL_LINES"
echo "Total Words    : $TOTAL_WORDS"
echo "Total Chars    : $TOTAL_CHARS"
echo "Error Lines    : $ERROR_LINES"
echo "Warning Lines  : $WARNING_LINES"
echo "Info Lines     : $INFO_LINES"
echo "----------------------------------------------"
echo "Report saved to $output"
