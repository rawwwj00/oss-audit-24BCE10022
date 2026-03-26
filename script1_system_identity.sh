#!/bin/bash
# ============================================================
# Script 1: System Identity Report
# Author: Raj Sachan | Reg No: 24BCE10022
# Course: Open Source Software | OSS Capstone Project
# Purpose: Displays a system welcome screen showing key OS
#          details, user info, uptime, and license information.
# ============================================================

# --- Student and Software Details ---
STUDENT_NAME="Raj Sachan"
REG_NUMBER="24BCE10022"
SOFTWARE_CHOICE="Python"

# --- Gather System Information using command substitution ---
KERNEL=$(uname -r)                          # Kernel version
DISTRO=$(cat /etc/os-release | grep PRETTY_NAME | cut -d= -f2 | tr -d '"')  # Distro name
USER_NAME=$(whoami)                         # Currently logged-in user
HOME_DIR=$HOME                              # Home directory of current user
UPTIME=$(uptime -p)                         # Human-readable uptime
CURRENT_DATE=$(date '+%A, %d %B %Y')        # e.g. Monday, 01 January 2025
CURRENT_TIME=$(date '+%H:%M:%S')            # e.g. 14:30:00
HOSTNAME=$(hostname)                        # Machine hostname

# --- License Message ---
# Linux (the OS running these scripts) is licensed under GPL v2.
# GPL v2 ensures the kernel source remains open and freely modifiable.
LICENSE_MSG="This system runs Linux, licensed under the GNU General Public License v2 (GPL v2)."

# --- Display the Report ---
echo "================================================================"
echo "        OPEN SOURCE AUDIT — SYSTEM IDENTITY REPORT"
echo "================================================================"
echo "  Student     : $STUDENT_NAME ($REG_NUMBER)"
echo "  Software    : $SOFTWARE_CHOICE (PSF License)"
echo "----------------------------------------------------------------"
echo "  Hostname    : $HOSTNAME"
echo "  Distribution: $DISTRO"
echo "  Kernel Ver  : $KERNEL"
echo "  Logged User : $USER_NAME"
echo "  Home Dir    : $HOME_DIR"
echo "  Uptime      : $UPTIME"
echo "  Date        : $CURRENT_DATE"
echo "  Time        : $CURRENT_TIME"
echo "----------------------------------------------------------------"
echo "  $LICENSE_MSG"
echo "================================================================"
echo ""
echo "  Python, the software being audited, is licensed under the"
echo "  Python Software Foundation License (PSF License) — a"
echo "  permissive, GPL-compatible open-source license."
echo "================================================================"
