#!/bin/bash
# ============================================================
# Script 3: Disk and Permission Auditor
# Author: Raj Sachan | Reg No: 24BCE10022
# Course: Open Source Software | OSS Capstone Project
# Purpose: Loops through important system directories, reports
#          permissions, owner, group, and disk usage.
#          Also checks Python's config directory specifically.
# ============================================================

# --- List of key system directories to audit ---
DIRS=("/etc" "/var/log" "/home" "/usr/bin" "/tmp" "/usr/lib" "/var")

echo "================================================================"
echo "       DISK AND PERMISSION AUDITOR — SYSTEM DIRECTORIES"
echo "================================================================"
printf "  %-20s %-25s %-10s\n" "DIRECTORY" "PERMISSIONS (type owner group)" "SIZE"
echo "  --------------------------------------------------------------------"

# --- For loop: iterate over each directory in the array ---
for DIR in "${DIRS[@]}"; do
    # Check if the directory exists before trying to inspect it
    if [ -d "$DIR" ]; then
        # Extract permissions, owner, group using ls -ld and awk
        # ls -ld output format: drwxr-xr-x 1 root root 4096 Jan 01 00:00 /etc
        PERMS=$(ls -ld "$DIR" | awk '{print $1, $3, $4}')

        # Get human-readable size using du; suppress permission errors with 2>/dev/null
        SIZE=$(du -sh "$DIR" 2>/dev/null | cut -f1)

        # Print formatted row
        printf "  %-20s %-25s %-10s\n" "$DIR" "$PERMS" "${SIZE:-N/A}"
    else
        # Directory does not exist on this system
        printf "  %-20s %s\n" "$DIR" "[does not exist on this system]"
    fi
done

echo ""
echo "================================================================"
echo "       PYTHON-SPECIFIC DIRECTORY CHECK"
echo "================================================================"

# --- Check Python's key directories specifically ---
# Python installs to different locations depending on the distro

# Array of common Python-related paths to check
PYTHON_DIRS=(
    "/usr/lib/python3"
    "/usr/lib/python3.10"
    "/usr/lib/python3.11"
    "/usr/lib/python3.12"
    "/usr/local/lib/python3"
    "/etc/python3"
    "/usr/bin/python3"
)

echo "  Checking Python installation paths..."
echo ""

# Track if we found at least one Python path
FOUND=0

for PYDIR in "${PYTHON_DIRS[@]}"; do
    # Check for both files and directories (python3 binary vs directories)
    if [ -e "$PYDIR" ]; then
        FOUND=1
        # Use ls -ld to get permissions for both files and directories
        PYPERMS=$(ls -ld "$PYDIR" | awk '{print $1, $3, $4}')
        PYSIZE=$(du -sh "$PYDIR" 2>/dev/null | cut -f1)
        printf "  %-35s %-25s %-10s\n" "$PYDIR" "$PYPERMS" "${PYSIZE:-N/A}"
    fi
done

# If none of the known Python paths were found, report that
if [ "$FOUND" -eq 0 ]; then
    echo "  No standard Python directories found. Python may not be installed"
    echo "  or may be in a non-standard location."
fi

echo ""
echo "  NOTE: Python libraries live in /usr/lib/pythonX.X/"
echo "  Configuration files may be in /etc/python3/ or per-user ~/.config/python"
echo "================================================================"
