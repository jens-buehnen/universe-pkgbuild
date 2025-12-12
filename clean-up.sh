#!/usr/bin/env bash 
#
# Script name: clean-up.sh
# Description: Script for deleting everything not named "PKGBUILD" or "*.install".
# GitLab: https://www.gitlab.com/dwt1/dtos-pkgbuild
# Contributors: Derek Taylor

# Set with the flags "-e", "-u","-o pipefail" cause the script to fail
# if certain things happen, which is a good thing.  Otherwise, we can
# get hidden bugs that are hard to discover.
set -euo pipefail

echo "$0"
full_path=$(realpath "$0")
dir_path=${full_path%/*}

readarray -t x86_list <<< "$(find x86_64/ -type d | awk -F / '{print $2}' | sort -u)"

for x in "${x86_list[@]}"
do
    cd "${dir_path}"/x86_64/"${x}"
    echo "Cleaning up: ${x}"
    if [ -f "PKGBUILD" ]; then
	git add PKGBUILD
    git add "${x}".install || echo "No install file found."
    git clean -dff
    else
        echo "No PKGBUILD found in ${PWD}"
    fi
done
