#!/bin/bash
# ============================================================
# Script 4: Log File Analyzer
# Author: Raj Sachan | Reg No: 24BCE10022
# Course: Open Source Software | OSS Capstone Project
# Purpose: Reads a log file line by line, counts occurrences
#          of a keyword, and prints a summary with last 5 matches.
#          Supports a retry mechanism if the file is empty.
# Usage:   ./script4_log_analyzer.sh <logfile> [keyword]
# Example: ./script4_log_analyzer.sh /var/log/syslog error
# ============================================================

# --- Accept command-line arguments ---
LOGFILE=$1                       # First argument: path to log file
KEYWORD=${2:-"error"}            # Second argument: keyword to search (default: "error")

# --- Counter variable to track keyword occurrences ---
COUNT=0

# --- Maximum retry attempts if file is empty ---
MAX_RETRIES=3
RETRY=0

echo "================================================================"
echo "        LOG FILE ANALYZER"
echo "================================================================"
echo "  Log File : $LOGFILE"
echo "  Keyword  : $KEYWORD"
echo "----------------------------------------------------------------"

# --- Validate: check that a log file argument was provided ---
if [ -z "$LOGFILE" ]; then
    echo "  ERROR: No log file specified."
    echo "  Usage: $0 <logfile> [keyword]"
    echo "  Example: $0 /var/log/syslog error"
    exit 1
fi

# --- Validate: check that the file actually exists ---
if [ ! -f "$LOGFILE" ]; then
    echo "  ERROR: File '$LOGFILE' not found."
    echo "  Please provide a valid log file path."
    exit 1
fi

# --- Do-while style retry loop: retry if file is empty ---
# This simulates a do-while by using a while loop with a condition check inside
while true; do
    # Check if the file has content (non-zero size)
    if [ -s "$LOGFILE" ]; then
        # File has content — break out of retry loop and proceed
        break
    else
        RETRY=$((RETRY + 1))
        echo "  WARNING: Log file is empty. Attempt $RETRY of $MAX_RETRIES..."

        # If we've hit max retries, exit gracefully
        if [ "$RETRY" -ge "$MAX_RETRIES" ]; then
            echo "  File remains empty after $MAX_RETRIES checks. Exiting."
            exit 1
        fi

        # Wait 2 seconds before retrying (log file may be being written)
        sleep 2
    fi
done

echo "  Scanning log file... please wait."
echo ""

# --- While-read loop: read the file line by line ---
# IFS= preserves leading/trailing whitespace; -r prevents backslash interpretation
while IFS= read -r LINE; do
    # If the current line contains the keyword (case-insensitive with -i flag)
    if echo "$LINE" | grep -iq "$KEYWORD"; then
        COUNT=$((COUNT + 1))   # Increment counter
    fi
done < "$LOGFILE"              # Redirect file content as input to the loop

# --- Print Summary ---
echo "================================================================"
echo "  SCAN RESULTS"
echo "================================================================"
echo "  Keyword  '$KEYWORD' found : $COUNT times"
echo "  Total lines in file      : $(wc -l < "$LOGFILE")"
echo "  File size                : $(du -sh "$LOGFILE" | cut -f1)"
echo "----------------------------------------------------------------"

# --- Show last 5 matching lines ---
# Uses grep to find matches, then tail to get only the last 5
echo "  Last 5 lines containing '$KEYWORD':"
echo ""

MATCHES=$(grep -i "$KEYWORD" "$LOGFILE" | tail -5)

# Check if any matches were found before printing
if [ -z "$MATCHES" ]; then
    echo "  (no matches found)"
else
    # Print each matching line with a ">>" prefix for clarity
    while IFS= read -r MATCH_LINE; do
        echo "  >> $MATCH_LINE"
    done <<< "$MATCHES"
fi

echo ""
echo "================================================================"
echo "  Analysis complete."
echo "================================================================"
