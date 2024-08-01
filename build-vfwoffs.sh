#!/bin/bash

# Fail fast
set -e

source build-settings.sh

# -----------------------------------------------------------------------
# make VF web font

echo " "
echo "Making VF WOFFs..."

# removing old files
rm -rf "$vfwoff2Dir"

# making the VF-WOFF directories
mkdir -p "$vfwoff2Dir"

# finds all the VF-TTFs
find "$vfttfDir" -path '*.ttf' -print0 | while read -d $'\0' fontFile
do
    # Replaces .ttf with .woff2 in the ttf file name
    woff2name=$(basename "${fontFile/.ttf/.woff2}")
    # Makes the woff2
    fonttools ttLib.woff2 compress -o "$vfwoff2Dir/$woff2name" "$fontFile"
done