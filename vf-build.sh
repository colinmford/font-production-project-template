#!/bin/bash

# Fail fast
set -e

# -----------------------------------------------------------------------
# configure paths

sourcesDir="A  Font Sources"
buildDir="B  Builds"

otfDir="$buildDir/VF-OTFs"
ttfDir="$buildDir/VF-TTFs"
woffDir="$buildDir/VF-WOFFs"

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
    fileBaseName=${dsFile##*/}
    fontmake --mm-designspace "$dsFile" --output variable-cff2 --output-path "$otfDir/${fileBaseName/.designspace/-VF.otf}" --production-names --subroutinizer cffsubr --flatten-components
done

# -----------------------------------------------------------------------
# post-processing OTFS 

# this loops through otfs and applies dsig fix to them
find "$otfDir" -path '*.otf' -print0 | while read -d $'\0' otfFile
do
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
    fileBaseName=${dsFile##*/}
    fontmake --mm-designspace "$dsFile" --output variable --output-path "$ttfDir/${fileBaseName/.designspace/-VF.ttf}" --production-names --flatten-components
done

# -----------------------------------------------------------------------
# post-processing TTFS 

# this loops through otfs and applies dsig fix to them
find "$ttfDir" -path '*.ttf' -print0 | while read -d $'\0' ttfFile
do
    gftools fix-dsig --autofix "$ttfFile"
    gftools fix-nonhinting "$ttfFile" "$ttfFile"
    rm "${ttfFile/.ttf/-backup-fonttools-prep-gasp.ttf}"
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
# find "$sourcesDir" -type d -name "instances" -exec rm -rf {} +
