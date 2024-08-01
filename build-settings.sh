#!/bin/bash

# -----------------------------------------------------------------------
# Configuration for Adobe Tests

export CF_DEFAULT_URL="https://yourwebsite.com"
export CF_DEFAULT_FOUNDRY_CODE="YOUR"

# -----------------------------------------------------------------------
# configure paths

sourcesDir="A  Sources"
buildDir="B  Builds"
proofDir="D  Proofs"
buildScriptsDir="C  Production Files/Build Script"

otfDir="$buildDir/OTFs"
ttfDir="$buildDir/TTFs"
vfttfDir="$buildDir/VF-TTFs"
woff2Dir="$buildDir/WOFF2s"
vfwoff2Dir="$buildDir/VF-WOFF2s"

testDir="$proofDir/Tests"
