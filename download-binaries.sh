#!/usr/bin/env bash
SYSINT="site/binaries/sysinternals"

# Switch to the directory of this file
cd "$( dirname "${BASH_SOURCE[0]}" )"

# Install python packages in a venv
if [[ ! -f venv/bin/activate ]]; then
    echo "[*] Creating virtual python environment"
    python3 -m venv --clear --upgrade-deps ./venv
fi

echo "[*] Activating virtual python environment"
source venv/bin/activate

echo "[*] Installing python packages"
pip install -U self-unzip.html

################################### SYSINTERNALS ##############################
echo "[*] Creating and entering $SYSINT direcotry"
if [[ -d tmp-build ]]; then
    rm -rf $SYSINT
fi
mkdir -p $SYSINT
cd $SYSINT

echo "[*] Downloading Microfoft's sysinternals"
curl https://download.sysinternals.com/files/SysinternalsSuite.zip -o sysinternals.zip

# Only tested on mac, check on linux
unzip sysinternals.zip

# Create index file
cat << EOF > ../sysinternals.html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SysInternals</title>
</head>
<body>
    <h1>SysInternals</h1>
    <ul>
EOF

mkdir html
for FILE in *; do
    # Only process files
    if [[ -f "$FILE" ]]; then
        # example: test.exe -> html/test-exe.html
        OUTPUT_FILE="$(basename "$FILE" | tr . - | sed -e 's|^|html/|' -e 's/$/.html/')"
        echo "[*] $FILE -> $OUTPUT_FILE"
        echo -e "<li><a href='sysinternals/$FILE'>$(basename "$FILE")</a> (<a href='sysinternals/$OUTPUT_FILE'>HTML</a>)</li>" >> ../sysinternals.html
        # gzip since most files are well compressable
        # ascii85 since it is smaller for larger files
        # both are specified, since this makes the build process 
        self-unzip-html \
            --type download \
            --compression gzip \
            --encoding ascii85 \
            --output "$OUTPUT_FILE" \
            "$FILE"
    fi
done

cat << EOF >> ../sysinternals.html
</body>
</html>
EOF
