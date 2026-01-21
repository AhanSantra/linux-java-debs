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
  echo "  ./setup.sh --install <package>"
  echo "  ./setup.sh --remove <package>"
  echo "  ./setup.sh --purge <package>"
  echo "  ./setup.sh --remove-repo"
  echo ""
  exit 1
}

# ---- FLAGS ----
case "$1" in
  --remove-repo)
    echo "🗑 Removing Linux Java Debs repository..."

    sudo rm -f /etc/apt/sources.list.d/linux-java-debs.list
    sudo rm -f /usr/share/keyrings/linux-java-debs.gpg

    echo "🔄 Updating APT cache..."
    sudo apt update

    echo "✅ Repository removed successfully"
    ;;

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
    echo "📦 Packages available in Linux Java Debs repository:"
    echo ""

    LIST_FILE="/var/lib/apt/lists/ahansantra.github.io_linux-java-debs_dists_stable_main_binary-amd64_Packages"

    if [ ! -f "$LIST_FILE" ]; then
      echo "❌ Repository not found in APT cache."
      echo "➡ Run: ./setup.sh --add-repo"
      exit 1
    fi

    awk '/^Package:/ {print " - " $2}' "$LIST_FILE"
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

  --remove)
    [ -z "$2" ] && usage
    echo "🗑 Removing package: $2"
    sudo apt remove "$2"
    ;;

  --purge)
    [ -z "$2" ] && usage
    echo "🔥 Purging package: $2"
    sudo apt purge "$2"
    ;;

  *)
    usage
    ;;
esac

