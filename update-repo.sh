#!/bin/bash
set -e

DIST=stable
ARCH=amd64
COMP=main
KEY="15D644B0250C14E1DEC0D0EED5C7BB6739C103E3"

# Ensure dirs exist
mkdir -p dists/$DIST/$COMP/binary-$ARCH

echo "📦 Generating Packages..."
dpkg-scanpackages pool /dev/null > dists/$DIST/$COMP/binary-$ARCH/Packages
gzip -kf dists/$DIST/$COMP/binary-$ARCH/Packages

echo "🧾 Generating Release with hashes..."
apt-ftparchive release dists/$DIST > dists/$DIST/Release

echo "🔐 Signing Release..."
cd dists/$DIST
gpg --default-key "$KEY" -abs -o Release.gpg Release
gpg --default-key "$KEY" --clearsign -o InRelease Release

echo "✅ Repository updated (strong security)"

