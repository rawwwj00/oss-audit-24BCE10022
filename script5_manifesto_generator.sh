#!/bin/bash
# ============================================================
# Script 5: The Open Source Manifesto Generator
# Author: Raj Sachan | Reg No: 24BCE10022
# Course: Open Source Software | OSS Capstone Project
# Purpose: Interactively collects three answers from the user,
#          then generates and saves a personalised open-source
#          philosophy manifesto to a .txt file.
# ============================================================

# --- Alias concept demonstrated ---
# In a real interactive shell session, you might define:
#   alias today='date "+%d %B %Y"'
# Here we use the same idea via a function, since aliases don't
# work reliably inside non-interactive shell scripts.
get_today() {
    date '+%d %B %Y'
}

# --- Welcome Banner ---
echo "================================================================"
echo "       OPEN SOURCE MANIFESTO GENERATOR"
echo "       OSS Capstone | Raj Sachan | 24BCE10022"
echo "================================================================"
echo ""
echo "  Answer three questions to generate your personal"
echo "  open-source philosophy manifesto."
echo ""
echo "----------------------------------------------------------------"

# --- Question 1: Collect user input with read -p ---
read -p "  1. Name one open-source tool you use every day: " TOOL

# --- Question 2: What does freedom mean to the user ---
read -p "  2. In one word, what does 'freedom' mean to you? " FREEDOM

# --- Question 3: What would the user build and share ---
read -p "  3. Name one thing you would build and share freely: " BUILD

echo ""
echo "  Generating your manifesto..."
echo ""

# --- Date using our alias-equivalent function ---
DATE=$(get_today)

# --- Output filename: personalised with the current username ---
# String concatenation: variable + string + variable
OUTPUT="manifesto_$(whoami).txt"

# --- Compose the manifesto and write to file using > (overwrite) ---
# Each echo >> appends a new line to the file

# Start fresh — overwrite any existing manifesto file
echo "================================================================" > "$OUTPUT"
echo "   OPEN SOURCE MANIFESTO" >> "$OUTPUT"
echo "   Generated on: $DATE" >> "$OUTPUT"
echo "   By: $(whoami) | Raj Sachan | 24BCE10022" >> "$OUTPUT"
echo "================================================================" >> "$OUTPUT"
echo "" >> "$OUTPUT"

# --- Compose the personalised paragraph using string concatenation ---
echo "  Every day, I reach for $TOOL — a tool I did not pay for," >> "$OUTPUT"
echo "  built by people I have never met, shared without condition." >> "$OUTPUT"
echo "  To me, '$FREEDOM' is the single word that captures what open" >> "$OUTPUT"
echo "  source truly means: not the absence of cost, but the presence" >> "$OUTPUT"
echo "  of choice, of access, of trust between strangers." >> "$OUTPUT"
echo "" >> "$OUTPUT"
echo "  I believe in the open-source way not just as a licensing" >> "$OUTPUT"
echo "  model, but as a philosophy of generosity. One day, I intend" >> "$OUTPUT"
echo "  to build $BUILD and release it freely — so that someone" >> "$OUTPUT"
echo "  I will never know can use it, improve it, and pass it on." >> "$OUTPUT"
echo "" >> "$OUTPUT"
echo "  That is what standing on the shoulders of giants means." >> "$OUTPUT"
echo "  Not just taking — but adding your own stone to the tower" >> "$OUTPUT"
echo "  so the next person can see a little further." >> "$OUTPUT"
echo "" >> "$OUTPUT"
echo "  — Written in the spirit of Python, the PSF License, and" >> "$OUTPUT"
echo "    the open-source community that built the modern world." >> "$OUTPUT"
echo "" >> "$OUTPUT"
echo "================================================================" >> "$OUTPUT"

# --- Confirm the file was saved ---
echo "  Manifesto saved to: $OUTPUT"
echo ""
echo "================================================================"
echo "   YOUR MANIFESTO:"
echo "================================================================"

# --- Display the saved manifesto back to the user ---
cat "$OUTPUT"
