#!/bin/bash

# Fail fast
set -e

source build-settings.sh

# -----------------------------------------------------------------------
# Compat Check before continuing

echo "Checking Compatibility..."

find "$sourcesDir" -maxdepth 1 -path '*.designspace' -print0 | while read -d $'\0' dsFile
do
    echo "Checking ${dsFile}"
    fonttools varLib.interpolatable --ignore-missing "$dsFile"
    echo "... Passed: ${dsFile}"
done