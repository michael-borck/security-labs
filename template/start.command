#!/usr/bin/env bash
# macOS double-click entry point — logs you into the lab's workstation shell.
cd "$(dirname "$0")" && exec bash scripts/lab-console
