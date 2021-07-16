#!/bin/bash

# Fail fast
set -e

# -----------------------------------------------------------------------
# configure paths

sourcesDir="A  Font Sources"
buildDir="B  Builds"

otfDir="$buildDir/OTFs"
ttfDir="$buildDir/TTFs"
woffDir="$buildDir/WOFFs"

# -----------------------------------------------------------------------
# build OTFs

echo "Building OTFs..."

# making the otf directory if it doesn't exist
mkdir -p "$otfDir"

# removing old files if it did
rm -rf "$otfDir/*.otf"

# making the otf files from the designspace file
find "$sourcesDir" -path '**/*.designspace' -print0 | while read -d $'\0' dsFile
do
    fontmake --mm-designspace "$dsFile" --output otf --interpolate --output-dir "$otfDir" --production-names --overlaps-backend pathops --subroutinizer cffsubr --flatten-components
done

# -----------------------------------------------------------------------
# post-processing OTFS 

# this loops through otfs and applies PS hinting to them
find "$otfDir" -path '*.otf' -print0 | while read -d $'\0' otfFile
do
    psautohint --all "$otfFile"
    gftools fix-dsig --autofix "$otfFile"
done

# -----------------------------------------------------------------------
# build TTFs

echo " "
echo "Building TTFs..."

# making the ttf directory if it doesn't exist
mkdir -p "$ttfDir"

# removing old files if it did
rm -rf "$ttfDir/*.ttf"

# making the ttfs from the designspace file
find "$sourcesDir" -path '**/*.designspace' -print0 | while read -d $'\0' dsFile
do
    fontmake --mm-designspace "$dsFile" --output ttf --interpolate --output-dir "$ttfDir" --production-names --overlaps-backend pathops --flatten-components
done

# -----------------------------------------------------------------------
# post-processing TTFS 

# this loops through otfs and uses the TTFAutoHinter to autohint them
find "$ttfDir" -path '*.ttf' -print0 | while read -d $'\0' ttfFile
do
    "./C  Project Files/bin/ttfautohint-1.8.3" --no-info --stem-width-mode=qsn "$ttfFile" "$ttfFile-output"
    rm "$ttfFile"
    mv "$ttfFile-output" "$ttfFile"

    gftools fix-dsig --autofix "$ttfFile"
done


# -----------------------------------------------------------------------
# make web font

echo " "
echo "Making WOFF2s..."

# making the woff directory if it doesn't exist
mkdir -p "$woffDir"

# removing old files if it did
rm -rf "$ttfDir/*.woff2"

find "$ttfDir" -path '*.ttf' -print0 | while read -d $'\0' ttfFile
do
    # Replaces .ttf with .woff2 in the ttf file name
    woff2name=$(basename "${ttfFile/.ttf/.woff2}")

    fonttools ttLib.woff2 compress -o "$woffDir/$woff2name" "$ttfFile"
done


# -----------------------------------------------------------------------
# Cleanup

# A fancy way to get rid of the UFO instances folder made by fontmake, to keep this folder, comment this line out with a "#"
find "$sourcesDir" -type d -name "instances" -exec rm -rf {} +
