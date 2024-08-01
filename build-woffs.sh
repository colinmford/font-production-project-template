#!/bin/bash

# Fail fast
set -e

source build-settings.sh

# -----------------------------------------------------------------------
# make web font

echo " "
echo "Making WOFFs..."

# removing old files
rm -rf "$woff2Dir"

# making the VF-WOFF directories
mkdir -p "$woff2Dir"

# Finding all the TTFs and making them woffs
find "$ttfDir" -path '*.ttf' -print0 | while read -d $'\0' fontFile
do
    # Replaces .ttf with .woff2 in the ttf file name
    woff2name=$(basename "${fontFile/.ttf/.woff2}")
    # Makes the woff2
    fonttools ttLib.woff2 compress -o "$woff2Dir/$woff2name" "$fontFile"
done

