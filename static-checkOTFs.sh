#!/bin/bash

set -e

buildDir="B  Builds"
proofDir="D  Proofs"

otfDir="$buildDir/OTFs"

fontbakery check-universal -n --succinct --html "$proofDir/OTFs.html" "$otfDir/*.otf" 1>/dev/null 2>&1
