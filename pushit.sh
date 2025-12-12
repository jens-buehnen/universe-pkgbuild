#!/usr/bin/env bash
#
# Script name: pushit.sh
# Description: Script for pushing changes to dtos-pkgbuild to GitLab.
# GitLab: https://www.gitlab.com/dtos/dtos-pkgbuild
# Contributors: Derek Taylor

# Set with the flags "-e", "-u","-o pipefail" cause the script to fail
# if certain things happen, which is a good thing.  Otherwise, we can
# get hidden bugs that are hard to discover.
set -euo pipefail

BOLD='\e[1m'
GREEN='\e[92m'
RED='\e[91m'
YELLOW='\e[93m'
RESET='\e[0m'

print_info () {
    echo -ne "${BOLD}${YELLOW}$1${RESET}\n"
}

git status
git add -u && print_info "Git add updated files in this directory."
bash clean-up.sh && print_info "Cleaning up unwanted files."
git commit -m "Updating PKGBUILDs." && print_info "Commit Message: Updating PKGBUILDs."
git push && print_info "Git push completed."

