#!/bin/bash
# ============================================================
# Script 2: FOSS Package Inspector
# Author: Raj Sachan | Reg No: 24BCE10022
# Course: Open Source Software | OSS Capstone Project
# Purpose: Checks if Python (or related packages) is installed,
#          retrieves version info, and prints a philosophy note
#          using a case statement.
# ============================================================

# --- Package to inspect ---
# 'python3' is the standard package name on both apt and rpm systems
PACKAGE="python3"

# --- Detect package manager and check installation ---
# We support both rpm-based and apt-based distros
echo "================================================================"
echo "        FOSS PACKAGE INSPECTOR — $PACKAGE"
echo "================================================================"

# Check which package manager is available on this system
if command -v rpm &>/dev/null; then
    PKG_MANAGER="rpm"
elif command -v dpkg &>/dev/null; then
    PKG_MANAGER="dpkg"
else
    # Neither manager found — cannot proceed
    echo "No supported package manager found (rpm or dpkg)."
    exit 1
fi

echo "  Package Manager Detected: $PKG_MANAGER"
echo "----------------------------------------------------------------"

# --- Check if the package is installed using the correct manager ---
if [ "$PKG_MANAGER" = "rpm" ]; then
    # RPM-based check (Fedora, RHEL, CentOS)
    if rpm -q $PACKAGE &>/dev/null; then
        echo "  STATUS: $PACKAGE is INSTALLED."
        echo ""
        # Display key fields: Version, License, Summary
        rpm -qi $PACKAGE | grep -E 'Version|License|Summary'
    else
        echo "  STATUS: $PACKAGE is NOT installed on this RPM-based system."
        echo "  To install: sudo dnf install python3"
    fi
else
    # APT-based check (Ubuntu, Debian)
    if dpkg -l $PACKAGE 2>/dev/null | grep -q "^ii"; then
        echo "  STATUS: $PACKAGE is INSTALLED."
        echo ""
        # Show version and description
        dpkg -l $PACKAGE | grep "^ii" | awk '{print "  Version : "$3"\n  Description: "$5" "$6" "$7" "$8}'
    else
        echo "  STATUS: $PACKAGE is NOT installed on this APT-based system."
        echo "  To install: sudo apt install python3"
    fi
fi

echo ""
echo "  Installed Python version (direct check):"
# Use python3 --version as a universal fallback check
if command -v python3 &>/dev/null; then
    echo "  $(python3 --version)"
else
    echo "  python3 command not found in PATH."
fi

echo "----------------------------------------------------------------"

# --- Case statement: Print an open-source philosophy note ---
# based on the package name being inspected
case $PACKAGE in
    python3|python)
        echo "  PHILOSOPHY: Python — 'Batteries included, community powered.'"
        echo "  Built openly under the PSF License, Python proves that a language"
        echo "  shaped entirely by volunteers and governed transparently can become"
        echo "  the world's most popular programming language."
        ;;
    httpd|apache2)
        echo "  PHILOSOPHY: Apache — the web server that built the open internet."
        echo "  Powering ~30% of all websites, it showed that open collaboration"
        echo "  beats proprietary development at scale."
        ;;
    mysql|mariadb)
        echo "  PHILOSOPHY: MySQL — open source at the heart of millions of apps."
        echo "  Its dual-license model sparked debates about commercial open source"
        echo "  that continue to shape the industry today."
        ;;
    git)
        echo "  PHILOSOPHY: Git — born out of frustration with proprietary VCS tools."
        echo "  Linus Torvalds built it in days; it now underpins all of open source."
        ;;
    vlc)
        echo "  PHILOSOPHY: VLC — built by students, given to the world."
        echo "  A reminder that open source empowers individuals, not just corporations."
        ;;
    *)
        # Default case for any other package
        echo "  PHILOSOPHY: Every open-source package carries a philosophy:"
        echo "  the belief that knowledge shared freely grows stronger for all."
        ;;
esac

echo "================================================================"
