#!/bin/bash

set -e

source build-settings.sh

# -----------------------------------------------------------------------
# Run build suite

# TEMPLATE: Customize based on project needs

./build-checks.sh # Checks sources for compatibility
./build-otfs.sh # Builds OTFs from sources
./build-ttfs.sh # Builds TTFs from sources
./build-vfttfs.sh # Builds variable TTFs from sources

./build-woffs.sh # Builds WOFF/WOFF2s from TTFs, must come after ttfs
./build-vfwoffs.sh # Builds WOFF/WOFF2s from variable TTFs, must come after vfttfs

# -----------------------------------------------------------------------
# Tests

# TEMPLATE: Disable these tests if you don't need them
./build-test.sh # Runs tests (fontbakery, etc) on built fonts

# -----------------------------------------------------------------------
say -v Zarvox "Build Complete"