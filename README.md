# OSS Audit — Python
### Open Source Software Capstone Project

| Field | Details |
|---|---|
| **Student Name** | Raj Sachan |
| **Registration Number** | 24BCE10022 |
| **Course** | Open Source Software (OSS NGMC) |
| **Software Audited** | Python (PSF License) |
| **Submission** | VITyarthi Portal |

---

## About This Project

This repository is a structured open-source audit of **Python** — one of the most widely used programming languages in the world, governed entirely by a community-driven foundation and released under the permissive Python Software Foundation (PSF) License.

The audit covers Python's origin story, its license and the four freedoms of free software, the ethics of open-source development, Python's Linux footprint, its FOSS ecosystem, and a comparison against its closest proprietary alternatives.

---

## Repository Structure

```
oss-audit-24BCE10022/
│
├── README.md                             ← This file
├── scripts/
│   ├── script1_system_identity.sh        ← System welcome screen
│   ├── script2_package_inspector.sh      ← FOSS package checker
│   ├── script3_disk_permission_auditor.sh← Directory audit
│   ├── script4_log_analyzer.sh           ← Log file keyword scanner
│   └── script5_manifesto_generator.sh    ← Interactive manifesto creator
└── OSS_Audit_Report_RajSachan.pdf        ← Full project report (12–16 pages)
```

---

## Shell Scripts — Description & Usage

### Script 1 — System Identity Report
**File:** `scripts/script1_system_identity.sh`

Displays a formatted welcome screen showing the Linux distribution name, kernel version, logged-in user, home directory, system uptime, current date/time, and a message about the OS license (GPL v2) and the audited software license (PSF).

**Concepts used:** Variables, `echo`, command substitution `$()`, output formatting, `uname`, `whoami`, `hostname`, `date`, `uptime`.

**Run:**
```bash
chmod +x scripts/script1_system_identity.sh
./scripts/script1_system_identity.sh
```

---

### Script 2 — FOSS Package Inspector
**File:** `scripts/script2_package_inspector.sh`

Detects whether the system uses `rpm` or `dpkg`, checks if `python3` is installed, retrieves version and license info, and uses a `case` statement to print an open-source philosophy note about the package.

**Concepts used:** `if-then-else`, `case` statement, `rpm -qi`, `dpkg -l`, `command -v`, pipe with `grep`, `awk`.

**Run:**
```bash
chmod +x scripts/script2_package_inspector.sh
./scripts/script2_package_inspector.sh
```

**Dependencies:** `rpm` (Fedora/RHEL) or `dpkg` (Ubuntu/Debian) — at least one must be present.

---

### Script 3 — Disk and Permission Auditor
**File:** `scripts/script3_disk_permission_auditor.sh`

Loops through a predefined list of key system directories (`/etc`, `/var/log`, `/home`, `/usr/bin`, `/tmp`, `/usr/lib`, `/var`) and reports permissions, owner, group, and disk usage. Then performs a dedicated check on Python-specific installation paths.

**Concepts used:** `for` loop, arrays, `ls -ld`, `du -sh`, `awk`, `cut`, conditional directory checks with `[ -d ]`.

**Run:**
```bash
chmod +x scripts/script3_disk_permission_auditor.sh
./scripts/script3_disk_permission_auditor.sh
```

---

### Script 4 — Log File Analyzer
**File:** `scripts/script4_log_analyzer.sh`

Accepts a log file path and optional keyword as command-line arguments. Reads the file line by line using a `while read` loop, counts how many lines contain the keyword (case-insensitive), prints a summary, and shows the last 5 matching lines. Includes a retry mechanism for empty files.

**Concepts used:** `while read` loop, `if-then`, counter variables (`$((COUNT + 1))`), command-line arguments (`$1`, `$2`), `grep -i`, `tail`, `wc -l`, `[ -s ]` (file size check), `[ -f ]` (file existence check).

**Run:**
```bash
chmod +x scripts/script4_log_analyzer.sh

# With a real log file:
./scripts/script4_log_analyzer.sh /var/log/syslog error

# On systems with /var/log/messages:
./scripts/script4_log_analyzer.sh /var/log/messages warning

# Test with any text file:
./scripts/script4_log_analyzer.sh /etc/os-release ID
```

**Note:** Run with `sudo` if the log file requires elevated permissions (e.g., `/var/log/auth.log`).

---

### Script 5 — The Open Source Manifesto Generator
**File:** `scripts/script5_manifesto_generator.sh`

An interactive script that asks the user three questions and generates a personalised open-source philosophy manifesto. The output is saved to a `.txt` file named `manifesto_<username>.txt` and also displayed on screen.

**Concepts used:** `read -p` for interactive input, string concatenation, writing to files with `>` and `>>`, `date` command, `cat`, function as alias equivalent, `$(whoami)` substitution.

**Run:**
```bash
chmod +x scripts/script5_manifesto_generator.sh
./scripts/script5_manifesto_generator.sh
```

---

## How to Run All Scripts (Quick Start)

```bash
# Clone the repository
git clone https://github.com/<your-username>/oss-audit-24BCE10022.git
cd oss-audit-24BCE10022

# Make all scripts executable
chmod +x scripts/*.sh

# Run each script
./scripts/script1_system_identity.sh
./scripts/script2_package_inspector.sh
./scripts/script3_disk_permission_auditor.sh
./scripts/script4_log_analyzer.sh /var/log/syslog error
./scripts/script5_manifesto_generator.sh
```

---

## Dependencies

| Dependency | Purpose | Install (Ubuntu) | Install (Fedora) |
|---|---|---|---|
| `bash` | Run all scripts | Pre-installed | Pre-installed |
| `python3` | Script 2 inspection target | `sudo apt install python3` | `sudo dnf install python3` |
| `dpkg` | Script 2 (apt systems) | Pre-installed on Ubuntu | N/A |
| `rpm` | Script 2 (rpm systems) | N/A | Pre-installed on Fedora |
| `coreutils` | `du`, `df`, `date`, `wc` | Pre-installed | Pre-installed |
| `grep` | Scripts 2, 3, 4 | Pre-installed | Pre-installed |

All scripts are compatible with **Bash 4.0+** and tested on Ubuntu 22.04 and Fedora 38.

---

## License

This project is submitted as academic coursework for the Open Source Software course at VIT. The shell scripts in this repository are released under the **MIT License** — in the spirit of the open-source philosophy documented in this audit.

---

*"Every line of code you write in your career will sit on top of open-source foundations. Understanding the philosophy behind that is not optional — it is part of being a professional."*
— OSS NGMC Course, VITyarthi
