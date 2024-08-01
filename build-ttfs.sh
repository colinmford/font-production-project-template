#!/bin/bash

# Fail fast
set -e

source build-settings.sh

# -----------------------------------------------------------------------
# build TTFs

echo " "
echo "Building TTFs..."

# removing old files
rm -rf "$ttfDir"

# making the ttf directory
mkdir -p "$ttfDir"

# TEMPLATE: Customize based on project needs
# remove "maxdepth 1" if you have subdirectories in your sources folder
# uncomment the below line if project uses UFOs instead of a designspace
# Also remove "--interpolate", "--check-compatibility", and "--expand-feature-to-instances"
# and change "--mm-designspace" to "--ufo-paths" if you are using UFOs
# adjust "-a" to match project, "nnn" better for display, "qqq" better for text
# #######################################################
# find "$sourcesDir" -maxdepth 1 -path '*.ufo' -print0 | while read -d $'\0' ufoFile
find "$sourcesDir" -maxdepth 1 -path '*.designspace' -print0 | while read -d $'\0' dsFile
do
    fontmake --mm-designspace "$dsFile" \
             --output ttf \
             --interpolate \
             --output-dir "$ttfDir" \
             --production-names \
             --overlaps-backend pathops \
             --flatten-components \
             --check-compatibility \
             -a "--no-info --stem-width-mode=nnn" \
             --filter "PropagateAnchorsFilter(pre=True)" \
             --filter "DecomposeTransformedComponentsFilter(pre=True)" \
             --expand-features-to-instances
done

# -----------------------------------------------------------------------
# post-processing TTFS 

find "$ttfDir" -path '*.ttf' -print0 | while read -d $'\0' fontFile
do
    # ... removes Mac names
    python "$buildScriptsDir/removeMacNames.py" "$fontFile"
    # ... makes hinting look good
    python "$buildScriptsDir/fixTTHintedFont.py" "$fontFile"
done

# -----------------------------------------------------------------------
# Cleanup

# A fancy way to get rid of the UFO instances folder made by fontmake, to keep this folder, comment this line out with a "#"
find "$sourcesDir" -type d -name "instances" -exec rm -rf {} +