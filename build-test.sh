#!/bin/bash

# Fail fast
set -e

source build-settings.sh

# -----------------------------------------------------------------------
# Tests
# The "1>/dev/null 2>&1 || true" stuff is to limit the output in the terminal

echo " "
echo "Running Tests..."

rm -rf "$testDir"

mkdir -p "$testDir"

fontbakery check-universal  -n --full-lists -l PASS --dark-theme --html "$testDir/Universal_OTFs.html" "$otfDir/*.otf" 1>/dev/null 2>&1 || true
fontbakery check-universal  -n --full-lists -l PASS --dark-theme --html "$testDir/Universal_TTFs.html" "$ttfDir/*.ttf" 1>/dev/null 2>&1 || true
fontbakery check-universal  -n --full-lists -l PASS --dark-theme --html "$testDir/Universal_VF-TTFs.html" "$vfttfDir/*.ttf" 1>/dev/null 2>&1 || true

# The OTF ones will fail if the font is missing blue values
compareFamily -d "$otfDir" -rm -rn -rp -l "$testDir/AFDKO_CompareFamily_OTFs.txt"
compareFamily -d "$ttfDir" -rm -rn -rp -l "$testDir/AFDKO_CompareFamily_TTFs.txt"