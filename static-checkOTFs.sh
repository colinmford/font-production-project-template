#!/bin/bash

set -e

buildDir="B  Builds"
proofDir="D  Proofs"

otfDir="$buildDir/OTFs"

fontbakery check-universal -n --succinct --html "$proofDir/OTFs.html" "$otfDir/*.otf"
