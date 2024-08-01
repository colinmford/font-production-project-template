#!/bin/bash

# Fail fast
set -e

source build-settings.sh

# -----------------------------------------------------------------------
# build VF-TTFs

echo " "
echo "Building VF-TTFs..."

# removing old files
rm -rf "$vfttfDir"

# making the vf-ttf directory
mkdir -p "$vfttfDir"

# making the ttfs from the designspace file
find "$sourcesDir" -maxdepth 1 -path '*.designspace' -print0 | while read -d $'\0' dsFile
do
    fontmake --mm-designspace "$dsFile" \
             --output variable \
             --output-dir "$vfttfDir" \
             --production-names \
             --keep-overlaps \
             --flatten-components \
             --check-compatibility \
             --filter "PropagateAnchorsFilter(pre=True)" \
             --filter "DecomposeTransformedComponentsFilter(pre=True)"
done

# -----------------------------------------------------------------------
# post-processing VF-TTFS 

find "$vfttfDir" -path '*.ttf' -print0 | while read -d $'\0' fontFile
do
    # ... removes Mac names
    python "$buildScriptsDir/removeMacNames.py" "$fontFile"
done
