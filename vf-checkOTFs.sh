#!/bin/bash

set -e

buildDir="B  Builds"
proofDir="D  Proofs"

otfDir="$buildDir/VF-OTFs"

fontbakery check-universal -n --succinct --html "$proofDir/VF-OTFs.html" "$otfDir/*.otf" 1>/dev/null 2>&1
