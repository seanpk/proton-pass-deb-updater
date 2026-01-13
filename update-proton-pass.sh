#!/usr/bin/env bash
# Proton Pass Linux Installer/Updater
# Gets newest Stable .deb from JSON

set -euo pipefail

JSON_URL="https://proton.me/download/PassDesktop/linux/x64/version.json"
DOWNLOAD_DIR="${HOME}/Downloads"

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${GREEN}Proton Pass Installer/Updater${NC}"
echo "Fetching latest version information..."

if ! command -v jq &> /dev/null; then
    echo -e "${YELLOW}Installing jq...${NC}"
    sudo apt update && sudo apt install -y jq
fi

json_data=$(curl -s --fail "$JSON_URL") || {
    echo -e "${RED}Failed to fetch JSON${NC}"
    exit 1
}

# jq filter: first Stable release with .deb - depends on Proton continuing to put the latest first
release_info=$(echo "$json_data" | jq -r '
  first(
    .Releases[]
    | select(.CategoryName == "Stable")
    | . as $parent
    | .File[]
    | select(.Identifier | contains(".deb"))
    | {
        version: $parent.Version,
        url: .Url,
        sha512: .Sha512CheckSum
      }
  )
')

if [[ "$release_info" == "null" || -z "$release_info" ]]; then
    echo -e "${RED}No valid Stable .deb release found${NC}"
    exit 1
fi

latest_version=$(echo "$release_info" | jq -r .version)
deb_url=$(echo "$release_info" | jq -r .url)
sha512_expected=$(echo "$release_info" | jq -r .sha512)

echo -e "Latest version: ${YELLOW}$latest_version${NC}"
echo -e "Download URL: ${YELLOW}$deb_url${NC}"

# Installed check (robust version)
installed_version=""
if dpkg-query --show proton-pass >/dev/null 2>&1; then
    installed_version=$(dpkg-query --showformat='${Version}\n' --show proton-pass 2>/dev/null || true)
    if [[ -n "$installed_version" ]]; then
        echo -e "Installed: ${YELLOW}$installed_version${NC}"
        if [[ "$installed_version" == "$latest_version" ]]; then
            echo -e "${GREEN}Already up to date — skipping download and reinstall.${NC}"
            exit 0
        else
            echo -e "${YELLOW}Different version detected — updating...${NC}"
        fi
    else
        echo "Package found but version could not be read. Proceeding."
    fi
else
    echo "Fresh install."
fi

# Download
DEB_FILENAME="proton-pass_${latest_version}_amd64.deb"
cd "$DOWNLOAD_DIR" || { echo -e "${RED}Cannot access $DOWNLOAD_DIR${NC}"; exit 1; }

echo "Downloading $DEB_FILENAME..."
curl -L -o "$DEB_FILENAME" --fail "$deb_url" || {
    echo -e "${RED}Download failed${NC}"
    exit 1
}

echo "Verifying SHA512..."
if ! echo "$sha512_expected  $DEB_FILENAME" | sha512sum --check --status; then
    echo -e "${RED}Checksum FAILED!${NC}"
    rm -f "$DEB_FILENAME"
    exit 1
fi

echo -e "${GREEN}Checksum OK ✓${NC}"

echo "Installing..."
sudo dpkg -i "$DEB_FILENAME"
sudo apt-get install -f -y

echo -e "${GREEN}Success! Proton Pass $latest_version is installed.${NC}"
echo "Launch from menu or run 'proton-pass'"
echo "File saved: $DOWNLOAD_DIR/$DEB_FILENAME"
