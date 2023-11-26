#!/usr/bin/env bash

# Switch to the directory of this file
cd "$( dirname "${BASH_SOURCE[0]}" )"

SYSINT="site/cyberchef"
VERSION="v10.5.2"
URL="https://github.com/gchq/CyberChef/releases/download/$VERSION/CyberChef_$VERSION.zip"
echo "[*] Creating and entering $SYSINT direcotry"
if [[ -d tmp-build ]]; then
    rm -rf $SYSINT
fi
mkdir -p $SYSINT
cd $SYSINT

echo "[*] Downloading GHCQ's CyberChef:"
echo "$URL"
# We need to follow the redirect to actually download the file
curl --location "$URL" -o cyberchef.zip

# Only tested on mac, check on linux
ls -l cyberchef.zip
unzip cyberchef.zip
rm cyberchef.zip

# Rename the index page
mv "CyberChef_$VERSION.html" index.html
