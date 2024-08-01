#!/bin/bash

# Fail fast
set -e

source build-settings.sh

# -----------------------------------------------------------------------
# build OTFs

echo ""
echo "Building OTFs..."

# removing old files
rm -rf "$otfDir"

# making the otf directory
mkdir -p "$otfDir"

# TEMPLATE: Customize based on project needs
# remove "maxdepth 1" if you have subdirectories in your sources folder
# uncomment the below line if project uses UFOs instead of a designspace
# Also remove "--interpolate", "--check-compatibility", and "--expand-feature-to-instances"
# and change "--mm-designspace" to "--ufo-paths" if you are using UFOs
# #######################################################
# find "$sourcesDir" -maxdepth 1 -path '*.ufo' -print0 | while read -d $'\0' ufoFile
find "$sourcesDir" -maxdepth 1 -path '*.designspace' -print0 | while read -d $'\0' dsFile
do
    # To learn more about these options, run `fontmake -h`
    fontmake --mm-designspace "$dsFile" \
             --output otf \
             --interpolate \
             --output-dir "$otfDir" \
             --production-names \
             --overlaps-backend pathops \
             --subroutinizer cffsubr \
             --optimize-cff 0 \
             --flatten-components \
             --check-compatibility \
             --filter "DottedCircleFilter(pre=True)" \
             --filter "PropagateAnchorsFilter(pre=True)" \
             --expand-features-to-instances
done

# -----------------------------------------------------------------------
# post-processing OTFS 

# this loops through otfs and applies PS hinting to them
find "$otfDir" -path '*.otf' -print0 | while read -d $'\0' fontFile
do
    # ... removes Mac names
    python "$buildScriptsDir/removeMacNames.py" "$fontFile"
    # ... applies autohinting - Will throw error if no blue zones are set.
    otfautohint "$fontFile" -v
    # ... re-subroutinize
    cffsubr --inplace "$fontFile"
done

# -----------------------------------------------------------------------
# Cleanup

# A fancy way to get rid of the UFO instances folder made by fontmake, to keep this folder, comment this line out with a "#"
find "$sourcesDir" -type d -name "instances" -exec rm -rf {} +
