#!/bin/bash

set -e

buildDir="B  Builds"
proofDir="D  Proofs"

ttfDir="$buildDir/TTFs"

fontbakery check-universal -n --succinct --html "$proofDir/TTFs.html" "$ttfDir/*.ttf"
