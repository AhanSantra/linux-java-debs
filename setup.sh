#!/bin/bash
set -e

REPO_URL="https://ahansantra.github.io/linux-java-debs"
KEY_URL="$REPO_URL/linux-java-debs.gpg"
LIST_FILE="/etc/apt/sources.list.d/linux-java-debs.list"
KEYRING="/usr/share/keyrings/linux-java-debs.gpg"

echo "🔧 Linux Java Debs Setup Script"
echo "=============================="

function usage() {
  echo ""
  echo "Usage:"
  echo "  ./setup.sh --add-repo"
  echo "  ./setup.sh --list"
  echo "  ./setup.sh --install <package-name>"
  echo "  ./setup.sh --install-all"
  echo ""
  exit 1
}

# ---- FLAGS ----
case "$1" in
  --add-repo)
    echo "🔑 Adding GPG key..."
    curl -fsSL "$KEY_URL" | sudo gpg --dearmor -o "$KEYRING"

    echo "📦 Adding APT source..."
    echo "deb [arch=amd64 signed-by=$KEYRING] $REPO_URL stable main" | sudo tee "$LIST_FILE"

    echo "🔄 Updating package list..."
    sudo apt update --allow-releaseinfo-change

    echo "✅ Repository added successfully"
    ;;

  --list)
    echo "📃 Available packages:"
    apt-cache search . | grep linux-java
    ;;

  --install)
    [ -z "$2" ] && usage
    echo "⬇ Installing package: $2"
    sudo apt install "$2"
    ;;

  --install-all)
    echo "⬇ Installing all Linux Java packages..."
    sudo apt install $(apt-cache search linux-java | awk '{print $1}')
    ;;

  *)
    usage
    ;;
esac

