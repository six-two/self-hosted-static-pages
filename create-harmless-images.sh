#!/usr/bin/env bash
# Run this after updating/changing the site/images/harmless.svg file to generate the variants of it

# Switch to the directory of this file
cd "$( dirname "${BASH_SOURCE[0]}" )"

# Paths are easier if we are in the image directory
cd site/images/

convert harmless.svg harmless.bmp
convert harmless.svg harmless.jpeg
convert harmless.svg harmless.png
